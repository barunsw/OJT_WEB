package com.barunsw.websample.sjcha;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.barunsw.websample.vo.AddressVo;

@Repository
public interface SampleDao {
	public List<AddressVo> selectList() throws Exception;
	
	public int insertAddress(AddressVo addressVo) throws Exception;
	
	public int deleteAddress(AddressVo addressVo) throws Exception;
	
	public int updateAddress(AddressVo addressVo) throws Exception;
	
}
