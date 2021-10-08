using PostgresCRUD.Models;  
using System.Collections.Generic;  
  
namespace PostgresCRUD.DataAccess  
{  
    public interface IDataAccessProvider  
    {  
        void AddShoeItem(ShoeItem shoe);  
        void UpdateShoeItem(ShoeItem shoe);  
        void DeleteShoeItem(string id);  
        ShoeItem GetSingleShoeItem(string id);  
        List<ShoeItem> GetShoeItems();  
    }  
} 