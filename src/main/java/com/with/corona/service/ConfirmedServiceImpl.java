package com.with.corona.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.with.corona.dao.ConfirmedDAO;
import com.with.corona.vo.ForeignVO;
import com.with.corona.vo.KoreaVO;

@Service
public class ConfirmedServiceImpl implements ConfirmedService {

	@Autowired
	ConfirmedDAO confirmedDAO;
	
	@Override
	public Map kConfirm() {
		return confirmedDAO.kTodayConfirmed();
	}
	
	@Override
	public void kUpdateToAuto() {
		confirmedDAO.kUpdateToAuto();
	}
	
	@Override
	public void fUpdateToAuto() {
		confirmedDAO.fUpdateToAuto();
	}
	
	@Override
	public KoreaVO kLocCon(String loc) {
		return confirmedDAO.kLocConfirmed(loc);
	}
	
	@Override
	public ForeignVO fLocCon(String loc) {
		return confirmedDAO.fTodayConfirmed(loc);
	}
	
	@Override
	public void reset() {
		confirmedDAO.reset();
	}
	
	@Override
	public Map graph(int dataDate) {
		return confirmedDAO.graph(dataDate);
	}
	
}
