package com.barunsw.websample.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class AddressVo {
	private String name;
	private int age;
	private String address;
	
	public String getAddress() {
		return address;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	@Override
	public String toString() {
		return "AddressVo [name=" + name + ", age=" + age + ", address=" + address + "]";
	}
	
	
}
