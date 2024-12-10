variable "image_name" {        
      type = string    
}    
variable "availability_zones" {        
      type = list(string)        
      default = ["eu-central-1a"]    
}    
variable "service_ports" {        
      type = list(object({            
            internal = null            
            external = number            
            protocol = string        
      }))        
      default = [{                
            internal = 5101                
            external = 5102                
            protocol = "udp"            
      }]    
}          