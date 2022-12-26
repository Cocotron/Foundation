
@typedef CTRange

function CTMakeRange(location, length) {
    return { location:location, length:length };
}


function CTMakeRangeCopy(aRange)
{
    return { location:aRange.location, length:aRange.length };
}


function CTEmptyRange(aRange)
{
    return aRange.length === 0;
}


function CTMaxRange(aRange)
{
    return aRange.location + aRange.length;
}

function CTEqualRanges(lhsRange, rhsRange)
{
    return ((lhsRange.location === rhsRange.location) && (lhsRange.length === rhsRange.length));
}


function CTLocationInRange(aLocation, aRange)
{
    return ((aLocation >= aRange.location) && (aLocation < CTMaxRange(aRange)));
}


function CTUnionRange(lhsRange, rhsRange)
{
    var location = MIN(lhsRange.location, rhsRange.location);

    return CTMakeRange(location, MAX(CTMaxRange(lhsRange), CTMaxRange(rhsRange)) - location);
}


function CTIntersectionRange(lhsRange, rhsRange)
{
    if (CTMaxRange(lhsRange) < rhsRange.location || CTMaxRange(rhsRange) < lhsRange.location)
        return CTMakeRange(0, 0);

    var location = MAX(lhsRange.location, rhsRange.location);

    return CTMakeRange(location, MIN(CTMaxRange(lhsRange), CTMaxRange(rhsRange)) - location);
}


function CTRangeInRange(lhsRange, rhsRange)
{
    return (lhsRange.location <= rhsRange.location && CTMaxRange(lhsRange) >= CTMaxRange(rhsRange));
}


function CTStringFromRange(aRange)
{
    return "{" + aRange.location + ", " + aRange.length + "}";
}


function CTRangeFromString(aString)
{
    var comma = aString.indexOf(',');

    return { location:parseInt(aString.substring(1, comma - 1)), length:parseInt(aString.substring(comma + 1, aString.length)) };
}