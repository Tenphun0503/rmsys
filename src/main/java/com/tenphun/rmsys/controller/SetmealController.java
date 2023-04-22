package com.tenphun.rmsys.controller;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.tenphun.rmsys.common.R;
import com.tenphun.rmsys.dto.SetmealDto;
import com.tenphun.rmsys.entity.Setmeal;
import com.tenphun.rmsys.service.CategoryService;
import com.tenphun.rmsys.service.SetmealService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("setmeal")
public class SetmealController {
    @Autowired
    SetmealService setmealService;
    @Autowired
    CategoryService categoryService;


    @PostMapping
    public R<String> add(@RequestBody SetmealDto setmealDto){
        setmealService.addWithDishes(setmealDto);
        return R.success("Add 1");
    }

    @GetMapping("/page")
    public R<Page<SetmealDto>> getByPage(int page, int pageSize, String name){
        // Create a pagination object
        Page<Setmeal> setmealPage = new Page<>(page, pageSize);
        // Set condition
        LambdaQueryWrapper<Setmeal> wrapper = new LambdaQueryWrapper<>();
        wrapper.like(StringUtils.isNotEmpty(name), Setmeal::getName, name);
        wrapper.orderByDesc(Setmeal::getUpdateTime);
        setmealService.page(setmealPage, wrapper);

        // Set categoryName
        // Create a SetmealDto pagination
        Page<SetmealDto> setmealDtoPage = new Page<>(page, pageSize);
        // Copy all features except records
        BeanUtils.copyProperties(setmealPage, setmealDtoPage, "records");
        // Edit records
        List<SetmealDto> dtoList = new ArrayList<>();
        setmealPage.getRecords().forEach(item->{
            SetmealDto dto = new SetmealDto();
            BeanUtils.copyProperties(item, dto);
            dto.setCategoryName(categoryService.getById(item.getCategoryId()).getName());
            dtoList.add(dto);
        });
        setmealDtoPage.setRecords(dtoList);
        return R.success(setmealDtoPage);
    }

    @GetMapping("/{id}")
    public R<SetmealDto> getById(@PathVariable Long id){
        SetmealDto dto = setmealService.getByIdWithDishes(id);
        return R.success(dto);
    }

    @PutMapping
    public R<String> update(@RequestBody SetmealDto dto){
        setmealService.updateWithDishes(dto);
        return R.success("Update 1");
    }

    @DeleteMapping
    public R<String> delete(@RequestParam List<Long> ids){
        setmealService.deleteWithDishes(ids);
        return R.success("delete 1");
    }

    @PostMapping("/status/{status}")
    public R<String> updateStatus(List<Long> ids, @PathVariable Integer status){
        setmealService.updateStatus(ids, status);
        return R.success("update status 1");
    }



}
