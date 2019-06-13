package com.barunsw.websample.sample;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.barunsw.websample.vo.AddressVo;


@Controller
public class SampleController {
	private static final Logger LOGGER = LogManager.getLogger(SampleController.class);
	
	@Autowired
	private SampleService sampleService;
	
	
	@RequestMapping(value="/sample/view", method=RequestMethod.GET)
	public String sampleView() {
		return "sample/sample";
	}
	
	@RequestMapping(value="/sample", method=RequestMethod.GET)
	public @ResponseBody List<AddressVo> selectAddressList(AddressVo addressVo) {
		LOGGER.debug("selectAddressList");

		List<AddressVo> addressList = null;
		try {
			addressList = sampleService.selectList();	
		}
		catch (Exception ex) {
			LOGGER.error(ex.getMessage(), ex);
		}
		
		return addressList;
	}
}
