package com.tenphun.rmsys;

import com.tenphun.rmsys.dto.DishDto;
import com.tenphun.rmsys.entity.Dish;
import com.tenphun.rmsys.entity.DishFlavor;
import com.tenphun.rmsys.service.DishFlavorService;
import com.tenphun.rmsys.service.DishService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class RmsysApplicationTests {
    @Autowired
    DishService dishService;

    @Test
    void test(){
        Dish dish = dishService.getById(1397850140982161409L);
        DishDto dto = new DishDto();
        BeanUtils.copyProperties(dish, dto);
        System.out.println(dto);
        Dish dish1 = new Dish();
        BeanUtils.copyProperties(dto, dish1);
        System.out.println(dish1);
    }
}
