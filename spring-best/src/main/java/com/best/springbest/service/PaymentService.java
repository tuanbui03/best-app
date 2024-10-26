package com.best.springbest.service;

import com.best.springbest.model.Payment;
import com.best.springbest.repository.PaymentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
@Service
public class PaymentService {
    @Autowired
    PaymentRepository obRepository;
    public List<Payment> getAllPayment(){
        try{
            return obRepository.findAll();
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }
    public Payment getPaymentByID(int id){
        try{
            return obRepository.findPaymentsByID(id);
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return null;
    }
    public boolean addPayment(Payment ob){
        try{
            obRepository.save(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }
    public boolean updatePayment(Payment ob){
        try{
            obRepository.save(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }
    public boolean removePayment(int id){
        try{
            Payment ob = obRepository.findPaymentsByID(id);
            obRepository.delete(ob);
            return true;
        }catch (Exception e){
            System.out.print(e.getMessage());
        }
        return false;
    }
}
