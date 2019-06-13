package com.barunsw.websample.gtkim;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class Main {
	
	@RequestMapping(value="/gtkim", method=RequestMethod.GET)
	public String mainView() {
		return "main/main";
	}
}
