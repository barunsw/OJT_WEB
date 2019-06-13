package com.barunsw.websample.sample;

import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.barunsw.websample.vo.AddressVo;

@Controller
public class MainController {
	private static final Logger LOGGER = LogManager.getLogger(MainController.class);

	@Autowired
	private SampleService sampleService;
	
	@RequestMapping(value="", method=RequestMethod.GET)
	public String mainView(Model model) throws Exception {
		LOGGER.debug("Main");
		model.addAttribute("list",sampleService.selectList());
		return "main/main";
	}
	
	@ResponseBody
	@RequestMapping(value="/insert",method=RequestMethod.POST)
	public int insertAddress(String Name, String Age, String Address) throws Exception{
		LOGGER.debug("insertAddress");
		AddressVo addressVo = new AddressVo();
		addressVo.setName(Name);
		addressVo.setAge(Integer.parseInt(Age));
		addressVo.setAddress(Address);
		
		return sampleService.insertAddress(addressVo);
		
	}
	
	@ResponseBody
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public int deleteAddress(@RequestBody Map<String, Object> map ) throws Exception{
		LOGGER.debug("deleteAddress");


		AddressVo addressVo = new AddressVo();
		addressVo.setName(map.get("Name").toString());
		addressVo.setAge(Integer.parseInt(map.get("Age").toString()));
		addressVo.setAddress(map.get("Address").toString());
		
		return sampleService.deleteAddress(addressVo);
	}
	
	@ResponseBody
	@RequestMapping(value="/update",method=RequestMethod.POST)
	public int updateAddress(String Name, String Age, String Address) throws Exception{
		LOGGER.debug("updateAddress");


		AddressVo addressVo = new AddressVo();
		addressVo.setName(Name);
		addressVo.setAge(Integer.parseInt(Age));
		addressVo.setAddress(Address);
		
		return sampleService.updateAddress(addressVo);
	}
	
}
