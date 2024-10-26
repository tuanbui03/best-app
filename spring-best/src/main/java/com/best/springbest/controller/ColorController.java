package com.best.springbest.controller;

import com.best.springbest.model.Color;
import com.best.springbest.service.ColorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@CrossOrigin(origins = "*")
@RestController
public class ColorController {
    @Autowired
    ColorService colorService;
    @RequestMapping(value = "api/best_app/color/all", method = RequestMethod.GET)
    public List<Color> getAllColors(){
        return colorService.getAllColor();
    }
    @RequestMapping(value = "api/best_app/color/detail", method = RequestMethod.GET)
    public Object getColorByID(@RequestParam int id){
        return colorService.getColorByID(id);
    }
    @RequestMapping(value = "api/best_app/color/create", method = RequestMethod.POST)
    public boolean addColor(@RequestBody Color Color) {
        return colorService.addColor(Color);
    }
    @RequestMapping(value = "api/best_app/color/update", method = RequestMethod.PUT)
    public boolean updateColor(@RequestBody Color Color) {
        return colorService.updateColor(Color);
    }
    @RequestMapping(value = "api/best_app/color/delete", method = RequestMethod.DELETE)
    public boolean removeColor(@RequestParam int id){
        return colorService.removeColor(id);
    }
}
