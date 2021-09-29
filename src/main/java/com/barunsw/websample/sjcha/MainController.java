package com.barunsw.websample.sjcha;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.barunsw.websample.sjcha.SampleService;

@Controller
@RequestMapping(value="/sjcha")
public class MainController {

	private static Logger LOGGER = LogManager.getLogger(MainController.class);

	@Autowired
	private SampleService sampleService;

	// /sjcha 주소 입력 후 main/main.jsp 호출.
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String mainView(Model model) throws Exception {
		LOGGER.debug("mainView() : start MainController");

		model.addAttribute("list", sampleService.selectList());

		return "main/main";
	}
}
