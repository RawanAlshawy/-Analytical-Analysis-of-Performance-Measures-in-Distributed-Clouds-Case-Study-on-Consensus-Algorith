function strData = serializeCell(cellArray)
strData = '';
% cellArray
for i=1:length(cellArray)
    cellDiv = cellArray{i};
    if iscell(cellDiv)
        for j=1:length(cellDiv)
            cellDivX = cellDiv{j};
            if iscell(cellDivX)
                for k=1:length(cellDivX)
                    if isstring(cellDivX{k})
                        strData = [cellDivX{k}, strData];
                    else
                        strData = [num2str(cellDivX{k}), strData];
                    end
                end
            else
                if isstring(cellDivX)
                    strData = [cellDivX, strData];
                else
                    strData = [num2str(cellDivX), strData];
                end
            end
        end
    else
        if isstring(cellDiv)
            strData = [cellDiv, strData];
        else
            strData = [num2str(cellDiv), strData];
        end
    end
    
end

