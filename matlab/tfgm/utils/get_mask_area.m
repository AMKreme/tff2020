function [mask_area, varargout] = get_mask_area(mask)
%compute mask area

mask_area = sum(mask(:));
mask_area_ratio = mask_area/ (size(mask,1)*size(mask,2));
 varargout{1} = mask_area_ratio;
       
end


