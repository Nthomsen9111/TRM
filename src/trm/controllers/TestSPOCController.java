package trm.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestSPOCController {
	//function that will take data for SPOC and store it into object with DAO
	//currently simply returns the same view
	@RequestMapping(value="SPOCInputData")
	public String spocInputData()
	{
		//insert into dataBase
		//int ret = new CustomerCRUDService().updateCustomer(customer.getCustId(), customer.getCustCity(), customer.getCustPhone());
		
		return "SPOCForm";
	}
}