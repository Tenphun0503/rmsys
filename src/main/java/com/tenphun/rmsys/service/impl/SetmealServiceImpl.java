package com.tenphun.rmsys.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tenphun.rmsys.dto.SetmealDto;
import com.tenphun.rmsys.entity.Setmeal;
import com.tenphun.rmsys.entity.SetmealDish;
import com.tenphun.rmsys.mapper.SetmealMapper;
import com.tenphun.rmsys.service.SetmealDishService;
import com.tenphun.rmsys.service.SetmealService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Service
public class SetmealServiceImpl extends ServiceImpl<SetmealMapper, Setmeal> implements SetmealService {

    @Autowired
    SetmealDishService setmealDishService;
    @Override
    public void addWithDishes(SetmealDto setmealDto) {
        // save setmeal into setmeal table
        this.save(setmealDto);

        // get generated setmeal id
        Long id = setmealDto.getId();

        // save setmealId into each setmealDish entity in the setmealDishes
        List<SetmealDish> setmealDishes = setmealDto.getSetmealDishes();
        setmealDishes.forEach(item->{
            item.setSetmealId(String.valueOf(id));
        });

        // save setmealDishes into setmealDish table
        setmealDishService.saveBatch(setmealDishes);
    }
}


