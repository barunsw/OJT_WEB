package com.barunsw.websample.sjcha;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.barunsw.websample.vo.AddressVo;

@Service
public class SampleService {

	@Autowired
	private SampleDao sampleDao;

	public List<AddressVo> selectList() throws Exception {
		return sampleDao.selectList();
	}

	public int insertAddress(AddressVo addressVo) throws Exception {
		return sampleDao.insertAddress(addressVo);
	}

	public int updateAddress(AddressVo addressVo) throws Exception {
		return sampleDao.updateAddress(addressVo);
	}

	public int deleteAddress(AddressVo addressVo) throws Exception {
		return sampleDao.deleteAddress(addressVo);
	}
}
