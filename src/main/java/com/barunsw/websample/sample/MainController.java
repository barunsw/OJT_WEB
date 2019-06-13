package com.barunsw.websample.sample;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainController {
	private static final Logger LOGGER = LogManager.getLogger(MainController.class);

	@RequestMapping(value="", method=RequestMethod.GET)
	public String mainView() {
		LOGGER.debug("Main");
		return "main/main";
	}
}
