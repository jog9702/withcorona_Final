package com.with.corona.controller;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.with.corona.vo.ClinicVO;

@Controller
public class ClinicController {

	@RequestMapping(value="/search", method=RequestMethod.GET)
	String clinicSearch(Model model) {
		return "clinic";
	}
	
	@RequestMapping(value="/result", method=RequestMethod.GET)
	void clinicResult(
			HttpServletResponse response,
			HttpServletRequest request) {
		response.setContentType("text/html; charset=utf-8;");
		System.out.println("ClinicController");
		
		try {
			
			if("clinic".equals(request.getParameter("action"))) {
				String searchClinic = request.getParameter("searchClinic");
				
				System.out.println("Controller: "+ searchClinic);
				
				String url = "http://api.odcloud.kr/api/3072692/v1/uddi:9d420e87-8e70-4fb0-a54a-be1244249b2e_201909271427?page=1&perPage=3564&serviceKey=sI726jPqcVCuRbjGbsSgId%2BsznYVz20Kk7JJ0RJ7R09QQlrhYyYeeRWxOYXQqeWZXt2jQggrOrj5K2JytdxpsQ%3D%3D";
				String result = getStringFromURL(url);
				JSONParser jsonParser = new JSONParser();
				List<ClinicVO> clinicList = new ArrayList();

				try {
					Object obj = jsonParser.parse(result);

					if(obj instanceof JSONObject) {
						
						System.out.println("JSONObject");
						
						JSONObject json = new JSONObject();
						json = (JSONObject) obj;
						
						JSONArray json_arr = (JSONArray) json.get("data");
						
						for(int i=0; i<json_arr.size(); i++) {
							JSONObject item = (JSONObject) json_arr.get(i);
							String local = (String) item.get("시도");
							String name = (String) item.get("보건기관명");
							String info = (String) item.get("주소");
							String tel = (String) item.get("대표전화번호");
							
							if(info.contains(searchClinic)) {
								ClinicVO vo = new ClinicVO();
								
								vo.setClinicLocal(local);
								vo.setClinicName(name);
								vo.setClinicInfo(info);
								vo.setClinicTel(tel);
								clinicList.add(vo);
							}
						}
						for(int i=0; i<clinicList.size(); i++) {
							System.out.print(clinicList.get(i).getClinicName());
						}
						StringBuffer sb = new StringBuffer();
						sb.append("[");
						for(int i=0; i<clinicList.size(); i++) {
							if(i == 0) {
								sb.append("{");
							} else {
								sb.append(",{");
							}
							sb.append("\"clinicLocal\":\""+clinicList.get(i).getClinicLocal()+"\",");
							sb.append("\"clinicName\":\""+clinicList.get(i).getClinicName()+"\",");
							sb.append("\"clinicInfo\":\""+clinicList.get(i).getClinicInfo()+"\",");
							sb.append("\"clinicTel\":\""+clinicList.get(i).getClinicTel()+"\"");
							sb.append("}");
						}
						sb.append("]");
						response.getWriter().println(sb.toString());
						
					} else if(obj instanceof JSONArray) {
						
					}
					
				} catch(Exception e) {
					e.printStackTrace();
				}
				
			} else {
				
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	//보건소 정보를 가져오기위한 메소드 - 남모세
	public String getStringFromURL(String url) {
		StringBuffer result = new StringBuffer();
						
		try {
			URL urlObj = new URL(url);
			HttpURLConnection conn = null;
			conn = (HttpURLConnection) urlObj.openConnection();
			conn.setConnectTimeout(5000);
			conn.setReadTimeout(10000);
			conn.setRequestMethod("GET");
			conn.connect();
						
			InputStream is = conn.getInputStream();
			InputStreamReader isr = new InputStreamReader(is, "utf-8");
							
			BufferedReader br = new BufferedReader(isr);
			String line = null;
			do {
				line = br.readLine();
				if(line != null) {
					result.append(line);
				}	
			}while(line != null);
			
			} catch (Exception e) {
				
			e.printStackTrace();
		}
		return result.toString();
	}
	
}
