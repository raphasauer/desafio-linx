
    using PostgresCRUD.Models;  
    using System.Collections.Generic;  
    using System.Linq;  
      
    namespace PostgresCRUD.DataAccess  
    {  
        public class DataAccessProvider: IDataAccessProvider  
        {  
            private readonly PostgreSqlContext _context;  
      
            public DataAccessProvider(PostgreSqlContext context)  
            {  
                _context = context;  
            }  
      
            public void AddShoeItem(ShoeItem shoe)
            {  
                _context.shoes.Add(shoe);  
                _context.SaveChanges();  
            }  
      
            public void UpdateShoeItem(ShoeItem shoe)  
            {  
                _context.shoes.Update(shoe);  
                _context.SaveChanges();  
            }  
      
            public void DeleteShoeItem(string id)  
            {  
                var entity = _context.shoes.FirstOrDefault(t => t.id == int.Parse(id));  
                _context.shoes.Remove(entity);  
                _context.SaveChanges();  
            }  
      
            public ShoeItem GetSingleShoeItem(string id)  
            {  
                return _context.shoes.FirstOrDefault(t => t.id == int.Parse(id));  
            }  
      
            public List<ShoeItem> GetShoeItems()  
            {  
                return _context.shoes.ToList();  
            }  
        }  
    }  
