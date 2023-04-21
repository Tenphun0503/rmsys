package com.tenphun.rmsys.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tenphun.rmsys.dto.DishDto;
import com.tenphun.rmsys.entity.Dish;
import com.tenphun.rmsys.entity.DishFlavor;
import com.tenphun.rmsys.mapper.DishMapper;
import com.tenphun.rmsys.service.DishFlavorService;
import com.tenphun.rmsys.service.DishService;
import org.springframework.beans.BeanUtils;
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

    @Override
    public DishDto getByIdWithFlavor(Long id) {
        // query dish information
        Dish dish = this.getById(id);
        // query dish flavors
        LambdaQueryWrapper<DishFlavor> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(DishFlavor::getDishId, id);
        List<DishFlavor> flavorList = dishFlavorService.list(wrapper);
        // set info into dto
        DishDto dto = new DishDto();
        BeanUtils.copyProperties(dish, dto);
        dto.setFlavors(flavorList);
        return dto;
    }

    @Override
    public void updateWithFlavor(DishDto dishDto) {
        // update dish table
        this.updateById(dishDto);

        // clean current flavors
        LambdaQueryWrapper<DishFlavor> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(DishFlavor::getDishId, dishDto.getId());
        dishFlavorService.remove(wrapper);

        // update new flavors
        for (DishFlavor flavor : dishDto.getFlavors()) {
            flavor.setDishId(dishDto.getId());
            System.out.println(flavor.getDishId());
        }
        dishFlavorService.saveBatch(dishDto.getFlavors());
    }

    @Override
    public void deleteWithFlavor(Long[] ids) {
        for (Long id : ids) {
            // remove from dish table
            this.removeById(id);
            // remove flavors
            LambdaQueryWrapper<DishFlavor> wrapper = new LambdaQueryWrapper<>();
            wrapper.eq(DishFlavor::getDishId, id);
            dishFlavorService.remove(wrapper);
        }
    }

    @Override
    public void updateStatus(Long[] ids, Integer status) {
        for(Long id : ids){
            Dish dish = new Dish();
            dish.setId(id);
            dish.setStatus(status);
            this.updateById(dish);
        }
    }
}
