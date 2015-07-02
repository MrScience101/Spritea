function BubbleSort(array) 

   local arrayLength = #array
   local stillSorting = true
   local temp = 0               

    --print(array[1].z)

   while stillSorting do 
      stillSorting = false 
      for i = 1, arrayLength-1 do 
         if array[i+1].z < array[i].z        
         then 
            temp = array[i]       
            array[i] = array[i+1]     
            array[i+1] = temp        
            stillSorting = true
         end
      end 
   end
end 