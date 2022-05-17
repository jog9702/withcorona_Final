package com.with.corona.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.with.corona.dao.CoronaDAO;

@Service
public class CoronaServiceImpl implements CoronaService {

	@Autowired
	CoronaDAO coronadao;
	
}
