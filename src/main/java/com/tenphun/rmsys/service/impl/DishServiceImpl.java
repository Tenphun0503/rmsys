package com.tenphun.rmsys.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tenphun.rmsys.dto.DishDto;
import com.tenphun.rmsys.entity.Dish;
import com.tenphun.rmsys.entity.DishFlavor;
import com.tenphun.rmsys.mapper.DishMapper;
import com.tenphun.rmsys.service.DishFlavorService;
import com.tenphun.rmsys.service.DishService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;


@Service
@Transactional
public class DishServiceImpl extends ServiceImpl<DishMapper, Dish> implements DishService {
    @Autowired
    DishFlavorService dishFlavorService;
    /**
     * Save new dish, and save flavors to flavors table
     */
    @Override
    public void saveWithFlavor(DishDto dishDto) {
        // save dish into dish Table
        this.save(dishDto);
        // get id
        Long dishId = dishDto.getId();
        // save dish flavor
        List<DishFlavor> flavors = dishDto.getFlavors();
        flavors.forEach(item -> item.setDishId(dishId));
        dishFlavorService.saveBatch(flavors);
    }


}
