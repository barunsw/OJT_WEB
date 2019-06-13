package com.barunsw.websample.sample;

import java.util.List;

import org.springframework.stereotype.Service;

import com.barunsw.websample.vo.AddressVo;


public interface SampleService {
	public List<AddressVo> selectList() throws Exception;
	
	public int insertAddress(AddressVo addressVo) throws Exception;
	
	public int deleteAddress(AddressVo addressVo) throws Exception;
	
	public int updateAddress(AddressVo addressVo) throws Exception;
}
