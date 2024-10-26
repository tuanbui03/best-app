package com.best.springbest.controller;

import com.best.springbest.model.Size;
import com.best.springbest.service.SizeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@CrossOrigin(origins = "*")
@RestController
public class SizeController {
    @Autowired
    SizeService sizeService;
    @RequestMapping(value = "api/best_app/size/all", method = RequestMethod.GET)
    public List<Size> getAllSizes(){
        return sizeService.getAllSize();
    }
    @RequestMapping(value = "api/best_app/size/detail", method = RequestMethod.GET)
    public Object getSizeByID(@RequestParam int id){
        return sizeService.getSizeByID(id);
    }
    @RequestMapping(value = "api/best_app/size/create", method = RequestMethod.POST)
    public boolean addSize(@RequestBody Size Size) {
        return sizeService.addSize(Size);
    }
    @RequestMapping(value = "api/best_app/size/update", method = RequestMethod.PUT)
    public boolean updateSize(@RequestBody Size Size) {
        return sizeService.updateSize(Size);
    }
    @RequestMapping(value = "api/best_app/size/delete", method = RequestMethod.DELETE)
    public boolean removeSize(@RequestParam int id){
        return sizeService.removeSize(id);
    }
}
