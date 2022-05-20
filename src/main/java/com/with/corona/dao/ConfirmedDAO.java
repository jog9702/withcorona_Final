package com.with.corona.dao;

import java.util.List;
import java.util.Map;

import com.with.corona.vo.ForeignVO;
import com.with.corona.vo.KoreaVO;

public interface ConfirmedDAO {

	public Map kTodayConfirmed();
	public void kUpdateToAuto();
	public void fUpdateToAuto();
	public KoreaVO kLocConfirmed(String loc);
	public ForeignVO fTodayConfirmed(String loc);
	public void reset();
	public Map graph();
	
}
