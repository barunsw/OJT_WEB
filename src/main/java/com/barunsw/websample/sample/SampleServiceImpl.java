package com.barunsw.websample.sample;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.barunsw.websample.vo.AddressVo;

@Service
public class SampleServiceImpl implements SampleService {

	@Autowired
	private SampleDao dao;
	
	@Override
	public List<AddressVo> selectList() throws Exception {
		return dao.selectList();
	}

	@Override
	public int insertAddress(AddressVo addressVo) throws Exception {
		return dao.insertAddress(addressVo);
	}

	@Override
	public int deleteAddress(AddressVo addressVo) throws Exception {
		return dao.deleteAddress(addressVo);
	}

	@Override
	public int updateAddress(AddressVo addressVo) throws Exception {
		return dao.updateAddress(addressVo);
	}
}
