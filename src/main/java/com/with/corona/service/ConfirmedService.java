package com.with.corona.service;

import java.util.List;
import java.util.Map;

import com.with.corona.vo.ForeignVO;
import com.with.corona.vo.KoreaVO;

public interface ConfirmedService {

	public Map kConfirm();
	public void kUpdateToAuto();
	public void fUpdateToAuto();
	public KoreaVO kLocCon(String loc);
	public ForeignVO fLocCon(String loc);
	public void reset();
	public Map graph();
	
}
