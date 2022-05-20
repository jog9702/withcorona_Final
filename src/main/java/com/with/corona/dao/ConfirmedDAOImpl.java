package com.with.corona.dao;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import com.with.corona.vo.KoreaVO;

import com.with.corona.vo.ForeignVO;


@Repository
public class ConfirmedDAOImpl implements ConfirmedDAO {

	DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
	Date date = new Date();
	String dateToStr = dateFormat.format(date);
	
	int dateTmp = Integer.parseInt(dateToStr);
	String dateToMinor = Integer.toString(dateTmp-3);
	String dateToMinornor = Integer.toString(dateTmp-7);
	String dateToMonth = dateToStr.substring(0, 6) + "01";
	String dateToYear = dateToStr.substring(0, 4) + "0101";
	
	String dateToMonthSql = dateToMonth.substring(2,4)+"/"+dateToMonth.substring(4,6)+"/"+dateToMonth.substring(6,8);
	String dateToYearSql = dateToYear.substring(2,4)+"/"+dateToYear.substring(4,6)+"/"+dateToYear.substring(6,8);
	
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public Map kTodayConfirmed() {
		Map map = new HashMap();
		int confirmedCase = (int)sqlSession.selectOne("mapper.confirmed.kTodayConfirmedCase");
		int monthconfirmedCase = (int)sqlSession.selectOne("mapper.confirmed.kMYConfirmedCase", dateToMonthSql);
		int yearconfirmedCase = (int)sqlSession.selectOne("mapper.confirmed.kMYConfirmedCase", dateToYearSql);
		int death = (int)sqlSession.selectOne("mapper.confirmed.kTodayDeathCase");
		
		System.out.println(dateToMonth.substring(2, 8));
		
		
		map.put("today", confirmedCase);
		map.put("month", monthconfirmedCase);
		map.put("year", yearconfirmedCase);
		map.put("death", death);
		
		return map;
	}
	
	@Override
	public void kUpdateToAuto() {
		System.out.println("updateToAuto 진입");
		sqlSession.update("mapper.confirmed.truncateTable", "korea_info");
		kUpdate(dateToMinornor, dateToStr);
		kUpdate(dateToMonth, dateToMonth);
		kUpdate(dateToYear, dateToYear);
	}
	
	@Override
	public void fUpdateToAuto() {
		sqlSession.update("mapper.confirmed.truncateTable", "foreign_info");
		fUpdate(dateToMinor, dateToStr);
	}
	
	@Override
	public KoreaVO kLocConfirmed(String loc) {
		KoreaVO vo = new KoreaVO();
		vo = sqlSession.selectOne("mapper.confirmed.kLocConfirmedCase", loc);
		System.out.println("dao vo"+vo.getKoreaDeath());
		return sqlSession.selectOne("mapper.confirmed.kLocConfirmedCase", loc);
	}
	
	@Override
	public ForeignVO fTodayConfirmed(String loc) {
		int fConfirmed = sqlSession.selectOne("mapper.confirmed.fTodayConfirmedCase", loc);
		int fDeath = sqlSession.selectOne("mapper.confirmed.fTodayDeathCase", loc);
		
		ForeignVO vo = new ForeignVO();
		vo.setForeignLocalInfo(fConfirmed);
		vo.setForeignDeath(fDeath);
		
		return vo;
	}
	
	@Override
	public void reset() {
		sqlSession.update("mapper.confirmed.dropSequence", "korea_info_seq");
		sqlSession.update("mapper.confirmed.dropSequence", "foreign_info_seq");
		sqlSession.update("mapper.confirmed.createSequence", "korea_info_seq");
		sqlSession.update("mapper.confirmed.createSequence", "foreign_info_seq");
		sqlSession.update("mapper.confirmed.dropTable", "korea_info");
		sqlSession.update("mapper.confirmed.dropTable", "foreign_info");
		sqlSession.update("mapper.confirmed.createKtable");
		sqlSession.update("mapper.confirmed.createFtable");
	}
	
	@Override
	public Map graph() {
		Map map = new HashMap();
		List<KoreaVO> list = new ArrayList();
		List<Integer> listDate = new ArrayList();
		List<Integer> listHeight = new ArrayList();
		list = sqlSession.selectList("mapper.confirmed.graph");
		
		for(int i=0; i<list.size()-1; i++) {
			int tmp = list.get(i).getKoreaLocalInfo() - list.get(i+1).getKoreaLocalInfo();
			listDate.add(tmp);
		}
		int tot = 0;
		for(int i=0; i<list.size(); i++) {
			tot += list.get(i).getKoreaLocalInfo(); 
		}
		for(int i=0; i<list.size(); i++) {
			listHeight.add( (int)((double)list.get(i).getKoreaLocalInfo()/tot*100));
		}
		map.put("vo", list);
		map.put("dis", listDate);
		map.put("height", listHeight);
		
		return map;
	}
	

	
	
	
	
	
	
	
	
	
	
	
	public void kUpdate(String date1, String date2) {
		String url = "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson?serviceKey=sIYnCEa6cv0btJb%2Bc2pWvDc76iYuhohbaoz%2B9bwsx8R2C8sPhrIivNMS3HHDCkVoBKoCktxoml4HN%2Bih04AWPQ%3D%3D&pageNo=1&numOfRows=10&";
		url += "startCreateDt=" + date1 + "&endCreateDt=" + date2;
		String result = getStringFromURL(url);

		List<KoreaVO> list = new ArrayList();
		try {
			

			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			StringReader sr = new StringReader(result);
			InputSource is = new InputSource(sr);

			Document doc = builder.parse(is);

			NodeList nodeList = doc.getElementsByTagName("item");
			for (int i = 0; i < nodeList.getLength(); i++) {
				Element el = (Element) nodeList.item(i);
				KoreaVO vo = new KoreaVO();

				NodeList nodes = el.getChildNodes();
				Node node2 = nodes.item(2);
				Element childElement2 = (Element) node2;
				vo.setKoreaAccumulate(Integer.parseInt(childElement2.getTextContent()));
				System.out.println(childElement2.getTextContent());
				
				Node node3 = nodes.item(3);
				Element childElement3 = (Element) node3;
				vo.setKoreaLocal(childElement3.getTextContent());
				System.out.println(childElement3.getTextContent());

				Node node1 = nodes.item(1);
				Element childElement1 = (Element) node1;
				vo.setKoreaDeath(Integer.parseInt(childElement1.getTextContent()));
				System.out.println(childElement1.getTextContent());

				Node node7 = nodes.item(7);
				Element childElement7 = (Element) node7;
				vo.setKoreaLocalInfo(Integer.parseInt(childElement7.getTextContent()));
				System.out.println(childElement7.getTextContent());

				Node node0 = nodes.item(0);
				Element childElement0 = (Element) node0;
				String timeBefore = childElement0.getTextContent();
				String time = timeBefore.substring(2, 10).replace("-", "/");
				vo.setKoreaTime(time);
				System.out.println(time);

//		Date type 삽입
//		Node node0 = nodes.item(0);
//		Element childElement0 = (Element) node0;
//		vo.setDate(childElement0.getTextContent());
				list.add(vo);
			}
			if (sr != null) {
				sr.close();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		for(int i=0; i<list.size(); i++) {
			sqlSession.insert("mapper.confirmed.kUpdateToAuto", list.get(i));
		}
	}
	
	public void fUpdate(String date1, String date2) {
		String url = "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19NatInfStateJson?serviceKey=sIYnCEa6cv0btJb%2Bc2pWvDc76iYuhohbaoz%2B9bwsx8R2C8sPhrIivNMS3HHDCkVoBKoCktxoml4HN%2Bih04AWPQ%3D%3D&pageNo=1&numOfRows=10&";
		url += "startCreateDt=" + date1 + "&endCreateDt=" + date2;
		String result = getStringFromURL(url);

		List<ForeignVO> list = new ArrayList();
		try {

			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			StringReader sr = new StringReader(result);
			InputSource is = new InputSource(sr);

			Document doc = builder.parse(is);

			NodeList nodeList = doc.getElementsByTagName("item");
			for (int i = 0; i < nodeList.getLength(); i++) {
				Element el = (Element) nodeList.item(i);
				ForeignVO vo = new ForeignVO();

				NodeList nodes = el.getChildNodes();

				Node node0 = nodes.item(0);
				Element childElement0 = (Element) node0;
				vo.setForeignLocalO(childElement0.getTextContent());
				System.out.println(childElement0.getTextContent());

				if (childElement0.getTextContent().equals("아시아")) {
					Node node7 = nodes.item(7);
					Element childElement7 = (Element) node7;
					vo.setForeignLocalI(childElement7.getTextContent());
					System.out.println(childElement7.getTextContent());

					Node node4 = nodes.item(4);
					Element childElement4 = (Element) node4;
					vo.setForeignDeath(Integer.parseInt(childElement4.getTextContent()));
					System.out.println(childElement4.getTextContent());

					Node node6 = nodes.item(6);
					Element childElement6 = (Element) node6;
					vo.setForeignLocalInfo(Integer.parseInt(childElement6.getTextContent()));
					System.out.println(childElement6.getTextContent());

					Node node3 = nodes.item(3);
					Element childElement3 = (Element) node3;
					String timeBefore = childElement3.getTextContent();
					System.out.println(timeBefore);
					String time = timeBefore.substring(2, 10).replace("-", "/");
					vo.setForeignTime(time);
					System.out.println(time);

//				Date type 삽입
//				Node node0 = nodes.item(0);
//				Element childElement0 = (Element) node0;
//				vo.setDate(childElement0.getTextContent());
					list.add(vo);
				}

			}
			if (sr != null) {
				sr.close();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		for(int i=0; i<list.size(); i++) {
			sqlSession.insert("mapper.confirmed.fUpdateToAuto", list.get(i));
		}
	}
	
	public String getStringFromURL(String url) {
		StringBuffer result = new StringBuffer();

		try {
			URL urlObj = new URL(url);
			HttpURLConnection conn = null;
			conn = (HttpURLConnection) urlObj.openConnection();
			conn.setConnectTimeout(5000);
			conn.setReadTimeout(50000);
			conn.setRequestMethod("GET");
			conn.connect();

			InputStream is = conn.getInputStream();
			InputStreamReader isr = new InputStreamReader(is, "utf-8");

			BufferedReader br = new BufferedReader(isr);
			String line = null;
			do {
				line = br.readLine();
				if (line != null) {
					result.append(line);
				}
			} while (line != null);

//			while( ( line = br.readLine() ) != null ) {
//				result.append(line);
//			}
			if (is != null) {
				is.close();
			}
			if (isr != null) {
				isr.close();
			}
			if (br != null) {
				br.close();
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result.toString();
	}
	
	
}
