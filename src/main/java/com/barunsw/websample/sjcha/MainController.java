package com.barunsw.websample.sjcha;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.barunsw.websample.vo.AddressVo;

@Controller
public class MainController {

	private static Logger LOGGER = LogManager.getLogger(MainController.class);

	@Autowired
	private SampleService sampleService;

	// /sjcha 주소 입력 후 main/main.jsp 호출.
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String mainView(Model model) throws Exception {
		return "main/main";
	}

	// /sjcha 주소 입력 후 main/main.jsp 호출.
	@RequestMapping(value="/sjcha", method=RequestMethod.GET)
	public String View(Model model) throws Exception {
		LOGGER.debug("mainView() : start MainController");

		LOGGER.debug("select data : " + sampleService.selectList());
		model.addAttribute("list", sampleService.selectList());

		return "main/main";
	}

	@RequestMapping(value="/list", method=RequestMethod.GET)
	public @ResponseBody List<AddressVo> selectAddressList() {
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

	@ResponseBody
	@RequestMapping(value="/save", method=RequestMethod.POST)
	public void insertView(String Name, String Age, String Address) throws Exception {
		LOGGER.debug("insertView() : insert data");

		AddressVo addressVo = new AddressVo();
		addressVo.setName(Name);
		addressVo.setAge(Integer.parseInt(Age));
		addressVo.setAddress(Address);

		sampleService.insertAddress(addressVo);
	}

	@ResponseBody
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public void updateView(String Name, String Age, String Address) throws Exception {
		LOGGER.debug("updateView() : update data");

		AddressVo addressVo = new AddressVo();
		addressVo.setName(Name);
		addressVo.setAge(Integer.parseInt(Age));
		addressVo.setAddress(Address);

		sampleService.updateAddress(addressVo);
	}
	
	@ResponseBody
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public void deleteView(String Name, String Age, String Address) throws Exception {
		LOGGER.debug("deleteView() : delete data");

		AddressVo addressVo = new AddressVo();
		addressVo.setName(Name);
		addressVo.setAge(Integer.parseInt(Age));
		addressVo.setAddress(Address);

		sampleService.deleteAddress(addressVo);
	}
}
