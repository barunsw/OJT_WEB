package com.barunsw.websample.sample;

import java.util.List;

import com.barunsw.websample.vo.AddressVo;

public interface SampleService {
	public List<AddressVo> selectList(AddressVo addressVo) throws Exception;
}
