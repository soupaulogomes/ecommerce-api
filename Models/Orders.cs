namespace Ecommerce.Api.Models
{
    public class Orders
    {
        public int Id { get; set; }
        public string CustomerName { get; set; } = string.Empty;
        public DateTime OrderDate { get; set; }
        public List<Product> Products { get; set; } = new List<Product>();
    }   
}