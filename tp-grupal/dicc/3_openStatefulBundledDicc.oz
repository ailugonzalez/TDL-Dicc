% OPEN STATEFUL BUNDLED
local NewDict D Val R in   
   fun {NewDict}
      local Tree in
         fun {Tree K V L R}
            tree(key:K value:V left:L right:R)
         end
         fun {Insert K V T}
            case T of nil then {Tree K V nil nil}
               [] tree(key:Y value:W left:L right:R) andthen K==Y then 
                  case W of nil then {Tree Y V L R}
                  else {Tree Y W|V L R}
                  end
               [] tree(key:Y value:W left:L right:R) andthen K<Y then {Tree Y W {Insert K V L} R}
               [] tree(key:Y value:W left:L right:R) andthen K>Y then {Tree Y W L {Insert K V R}}
               else nil
            end
         end
         fun {Lookup K T}
            case T of nil then nil
               [] tree(key:Y value:V left:L right:R) andthen K==Y then V
               [] tree(key:Y value:V left:L right:R) andthen K<Y then {Lookup K L}
               [] tree(key:Y value:V left:L right:R) andthen K>Y then {Lookup K R}
               else nil
            end
         end
      end
      C = {NewCell nil}
      proc {Put K V} 
         C:={Insert K V @C}
      end
      proc {Get K V} 
         V = {Lookup K @C} 
      end
      fun {Domain} 
         nil
      end
   in
      dictionary(put:Put get:Get domain:Domain data:C)
   end
   
   D = {NewDict}
   R = D.data
   {Browse @R}
   {D.put 'a' 4}
   {Browse @R}
   {D.put 'b' 10}
   {Browse @R}
   {D.get 'a' Val}
   {Browse Val}
end



