package com.with.corona.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.with.corona.service.CoronaService;

@Controller
public class CoronaController {
	
	@Autowired
	CoronaService coronaService;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	String memberList(Model model) {
		return "homepage";
	}
	
}
