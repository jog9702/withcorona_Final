package com.with.corona.controller;

import java.text.DecimalFormat;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.with.corona.service.ConfirmedService;
import com.with.corona.vo.ForeignVO;
import com.with.corona.vo.KoreaVO;

@Controller
public class ConfirmedController {
	
	@Autowired
	ConfirmedService confirmedService;
	
	@RequestMapping(value="/covidHomepage", method=RequestMethod.GET)
	String homePage(Model model, HttpServletRequest request, HttpServletResponse response) {
		
		try {
			confirmedService.kUpdateToAuto();
			
			DecimalFormat fmt = new DecimalFormat("###,###");
			model.addAttribute("todayCount", fmt.format(confirmedService.kConfirm().get("today")));
			model.addAttribute("monthCount", fmt.format(confirmedService.kConfirm().get("month")));
			model.addAttribute("yearCount", fmt.format(confirmedService.kConfirm().get("year")));
			model.addAttribute("todayDeath", fmt.format(confirmedService.kConfirm().get("death")));
		}catch(Exception e) {
			model.addAttribute("todayCount", -999);
			model.addAttribute("monthCount", -999);
			model.addAttribute("yearCount", -999);
			model.addAttribute("todayDeath", -999);
			model.addAttribute("glgl", "테이블을 초기화 하거나 관리자에게 문의해주세요 박정희 : 010-2373-6719");
		}
		
		
		return "homepage";
	}
	
	@RequestMapping(value="/covidKorea", method=RequestMethod.GET)
	String korea(Model model) {
		try {
			DecimalFormat fmt = new DecimalFormat("###,###");
			model.addAttribute("todayCount", fmt.format(confirmedService.kConfirm().get("today")));
			model.addAttribute("monthCount", fmt.format(confirmedService.kConfirm().get("month")));
			model.addAttribute("yearCount", fmt.format(confirmedService.kConfirm().get("year")));
			model.addAttribute("todayDeath", fmt.format(confirmedService.kConfirm().get("death")));
		}catch(Exception e) {
			model.addAttribute("todayCount", -999);
			model.addAttribute("monthCount", -999);
			model.addAttribute("yearCount", -999);
			model.addAttribute("todayDeath", -999);
			model.addAttribute("glgl", "테이블을 초기화 하거나 관리자에게 문의해주세요 박정희 : 010-2373-6719");
		}
		
		
		return "covidKorea";
	}
	
	@RequestMapping(value="/covidKoreaDetail", method=RequestMethod.GET)
	@ResponseBody KoreaVO koreaDetail(HttpServletRequest request) {
		String loc = (String)request.getParameter("loc");
		
		KoreaVO vo = confirmedService.kLocCon(loc);
		System.out.println("vo : "+vo.getKoreaDeath());
		return vo;
	}
	
	@RequestMapping(value="/covidForeignDetail", method=RequestMethod.GET)
	@ResponseBody ForeignVO ForeignDetail(HttpServletRequest request) {
		String loc = (String)request.getParameter("loc");
		
		ForeignVO vo = confirmedService.fLocCon(loc);
		vo.setForeignLocalI(loc);
		return vo;
	}
	
	@RequestMapping(value="/covidForeign", method=RequestMethod.GET)
	String foreign(Model model,  HttpServletRequest request) {
		try {
			confirmedService.fUpdateToAuto();
			DecimalFormat fmt = new DecimalFormat("###,###");
			model.addAttribute("kor", fmt.format(confirmedService.fLocCon("한국").getForeignLocalInfo()));
			model.addAttribute("chi", fmt.format(confirmedService.fLocCon("중국").getForeignLocalInfo()));
			model.addAttribute("jap", fmt.format(confirmedService.fLocCon("일본").getForeignLocalInfo()));
		}catch(Exception e) {
			model.addAttribute("kor", -999);
			model.addAttribute("chi", -999);
			model.addAttribute("jap", -999);
			model.addAttribute("glgl", "테이블을 초기화 하거나 관리자에게 문의해주세요 박정희 : 010-2373-6719");
		}
		
		return "covidForeign";
	}
	
	@RequestMapping(value="/reset", method=RequestMethod.GET)
	@ResponseBody void reset() {
		confirmedService.reset();
	}
	
	@RequestMapping(value="/graph", method=RequestMethod.GET)
	@ResponseBody Map graph(HttpServletRequest request) {
		
		return confirmedService.graph();
		
	}
	
}
