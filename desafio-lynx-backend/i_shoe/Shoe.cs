namespace PostgresCRUD.Models 
{
    public class ShoeItem
    {
        public int id { get; set; }
        public string modelname { get; set; }
        public string brand {get ; set;}
        public int stock {get; set;}
        public int size { get ; set;}
        public double price { get ; set;}
    }
}