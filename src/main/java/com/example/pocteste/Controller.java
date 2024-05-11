package com.example.pocteste;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class Controller {

    @GetMapping("/")
    public String getHello() {
        return "Serviço subiu com sucesso";
    }    
    
}
