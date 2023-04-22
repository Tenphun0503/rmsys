package com.tenphun.rmsys.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tenphun.rmsys.dto.SetmealDto;
import com.tenphun.rmsys.entity.Setmeal;
import com.tenphun.rmsys.entity.SetmealDish;
import com.tenphun.rmsys.mapper.SetmealMapper;
import com.tenphun.rmsys.service.SetmealDishService;
import com.tenphun.rmsys.service.SetmealService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.lang.invoke.LambdaMetafactory;
import java.util.Arrays;
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

    @Override
    public SetmealDto getByIdWithDishes(Long id) {
        // Create a SetmealDto Object
        SetmealDto dto = new SetmealDto();
        // query from setmeal table
        Setmeal setmeal = this.getById(id);
        BeanUtils.copyProperties(setmeal, dto);
        // query dishes from setmeal_dish table;
        LambdaQueryWrapper<SetmealDish> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SetmealDish::getSetmealId, id);
        List<SetmealDish> dishes = setmealDishService.list(wrapper);
        dto.setSetmealDishes(dishes);
        return dto;
    }

    @Override
    public void updateWithDishes(SetmealDto dto) {
        // Update setmeal table
        this.updateById(dto);

        // clean existed data in setmeal_dish table
        LambdaQueryWrapper<SetmealDish> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SetmealDish::getSetmealId, dto.getId());
        setmealDishService.remove(wrapper);

        // add new data in setmeal_dish table
        List<SetmealDish> dishes = dto.getSetmealDishes();
        dishes.forEach(item->item.setSetmealId(String.valueOf(dto.getId())));
        setmealDishService.saveBatch(dishes);
    }

    @Override
    public void deleteWithDishes(Long[] ids) {
        // batch delete setmeal with the given ids
        this.removeByIds(Arrays.asList(ids));

        // delete setmealDish with a matching setmealId
        LambdaQueryWrapper<SetmealDish> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(SetmealDish::getSetmealId, Arrays.asList(ids));
        setmealDishService.remove(wrapper);
    }

    @Override
    public void updateStatus(Long[] ids, Integer status) {
        Setmeal setmeal = new Setmeal();
        setmeal.setStatus(status);
        // Create a wrapper for batch updating
        LambdaQueryWrapper<Setmeal> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(Setmeal::getId, Arrays.asList(ids));
        // update records with the updated status
        this.update(setmeal, wrapper);
    }
}


