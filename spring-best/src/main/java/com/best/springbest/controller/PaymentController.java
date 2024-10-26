package com.best.springbest.controller;

import com.best.springbest.model.Payment;
import com.best.springbest.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@CrossOrigin(origins = "*")
@RestController
public class PaymentController {
    @Autowired
    PaymentService paymentService;
    @RequestMapping(value = "api/best_app/payment/all", method = RequestMethod.GET)
    public List<Payment> getAllPayments(){
        return paymentService.getAllPayment();
    }
    @RequestMapping(value = "api/best_app/payment/detail", method = RequestMethod.GET)
    public Payment getPaymentByID(@RequestParam int id){
        return paymentService.getPaymentByID(id);
    }
    @RequestMapping(value = "api/best_app/payment/create", method = RequestMethod.POST)
    public boolean addPayment(@RequestBody Payment payment){
        return paymentService.addPayment(payment);
    }
    @RequestMapping(value = "api/best_app/payment/update", method = RequestMethod.PUT)
    public boolean updatePayment(@RequestBody Payment payment){
        return paymentService.updatePayment(payment);
    }
    @RequestMapping(value = "api/best_app/payment/delete", method = RequestMethod.DELETE)
    public boolean removePayment(@RequestParam int id){
        return paymentService.removePayment(id);
    }
}
