//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ProductOrderApi.Models
{
    using Newtonsoft.Json;
    using System;
    using System.Collections.Generic;
    
    public partial class Customer
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Customer()
        {
            this.Orders = new HashSet<Order>();
        }
    
        public string CustID { get; set; }
        public string FullName { get; set; }
        public string City { get; set; }
        public string Country { get; set; }
        public string State { get; set; }
        public string PostCode { get; set; }
        public int SegID { get; set; }
        public string Region { get; set; }
    
        public virtual Region Region1 { get; set; }
        public virtual Segment Segment { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]

        //Include JSON IGNORE FOR CLEAN DATA VIEW
        [JsonIgnore]
        public virtual ICollection<Order> Orders { get; set; }
    }
}
