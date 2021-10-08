using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using PostgresCRUD.DataAccess;  
using PostgresCRUD.Models;  

namespace PostgresCRUD.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ShoeController: ControllerBase
    {
        private readonly IDataAccessProvider _dataAccessProvider;  
        
        public ShoeController(IDataAccessProvider dataAccessProvider)  
        {  
            _dataAccessProvider = dataAccessProvider;  
        }  

        private static List<ShoeItem> Shoes = new List<ShoeItem> {
            new ShoeItem { id= 1, modelname = "Running shoes", brand = "Adidas", size = 40, price = 199.99, stock = 40},
            new ShoeItem { id= 2, modelname = "Outdoor shoes", brand = "Timberland", size = 40, price = 399.99, stock=20}
        };
        [HttpGet]  
        public IEnumerable<ShoeItem> Get()  
        {  
            return _dataAccessProvider.GetShoeItems();  
        }  

        [HttpGet("{id}")]  
        public ShoeItem Details(string id)  
        {  
            return _dataAccessProvider.GetSingleShoeItem(id);  
        }  
        [HttpPost]
        public IActionResult Create([FromBody]ShoeItem shoeItem)          {
            if(ModelState.IsValid)
            {
                _dataAccessProvider.AddShoeItem(shoeItem);  
                return Ok(); 
            } 
            return BadRequest();  
            
        }
        [HttpPut]  
        public IActionResult Edit([FromBody]ShoeItem shoeItem)  
        {  
            if (ModelState.IsValid)  
            {  
                _dataAccessProvider.UpdateShoeItem(shoeItem);  
                return Ok();  
            }  
            return BadRequest();  
        } 
        [HttpDelete("{id}")]  
        public IActionResult DeleteConfirmed(string id)  
        {  
            var data = _dataAccessProvider.GetSingleShoeItem(id);  
            if (data == null)  
            {  
                return NotFound();  
            }  
            _dataAccessProvider.DeleteShoeItem(id);  
            return Ok();  
        }  
    }  
}
