#import "CTObject.j"
#import "CTArray.j"
#import "CTRange.j"


var positionOfIndex = function(ranges, anIndex)
{
    var low = 0,
        high = ranges.length - 1;

    while (low <= high)
    {
        var middle = FLOOR(low + (high - low) / 2),
            range = ranges[middle];

        if (anIndex < range.location)
            high = middle - 1;

        else if (anIndex >= CTMaxRange(range))
            low = middle + 1;

        else
            return middle;
   }

   return -1;
};

var assumedPositionOfIndex = function(ranges, anIndex)
{
    var count = ranges.length;

    if (count <= 0)
        return -1;

    var low = 0,
        high = count * 2;

    while (low <= high)
    {
        var middle = FLOOR(low + (high - low) / 2),
            position = middle / 2,
            positionFLOOR = FLOOR(position);

        if (position === positionFLOOR)
        {
            if (positionFLOOR - 1 >= 0 && anIndex < CTMaxRange(ranges[positionFLOOR - 1]))
                high = middle - 1;

            else if (positionFLOOR < count && anIndex >= ranges[positionFLOOR].location)
                low = middle + 1;

            else
                return positionFLOOR - 0.5;
        }
        else
        {
            var range = ranges[positionFLOOR];

            if (anIndex < range.location)
                high = middle - 1;

            else if (anIndex >= CTMaxRange(range))
                low = middle + 1;

            else
                return positionFLOOR;
        }
    }

   return -1;
};


@implementation CTIndexSet : CTObject
{
   Integer _count;
   CTArray _ranges; 
}

+ (id)indexSet
{
    return [[self alloc] init];
}

+ (id)indexSetWithIndex:(Integer)anIndex
{
    return [[self alloc] initWithIndex:anIndex];
}

+ (id)indexSetWithIndexesInRange:(CTRange)aRange
{
    return [[self alloc] initWithIndexesInRange:aRange];
}

- (id)init
{
    return [self initWithIndexesInRange:CTMakeRange(0, 0)];
}

/*!
    Initializes the index set with a single index.
    @return the initialized index set
*/
- (id)initWithIndex:(CPInteger)anIndex
{
    if (!_IS_NUMERIC(anIndex))
        throw new Error("Invalid index");

    return [self initWithIndexesInRange:CTMakeRange(anIndex, 1)];
}

- (id)initWithIndexesInRange:(CTRange)aRange
{
    if (aRange.location < 0)
        throw new Error("Range " + CTStringFromRange(aRange) + " is out of bounds.");

    self = [super init];

    if (self)
    {
        _count = MAX(0, aRange.length);

        if (_count > 0)
            _ranges = [aRange];
        else
            _ranges = [];
    }

    return self;
}

- (id)initWithIndexSet:(CTIndexSet)anIndexSet
{
    self = [super init];

    if (self)
    {
        _count = [anIndexSet count];
        _ranges = [];

        var otherRanges = anIndexSet._ranges,
            otherRangesCount = otherRanges.length;

        while (otherRangesCount--)
            _ranges[otherRangesCount] = CTMakeRangeCopy(otherRanges[otherRangesCount]);
    }

    return self;
}

/*!
    Returns \c YES if the index set contains the specified index.
    @param anIndex the index to check for in the set
    @return \c YES if \c anIndex is in the receiver index set
*/
- (BOOL)containsIndex:(CTInteger)anIndex
{
    return positionOfIndex(_ranges, anIndex) !== -1;
}

- (BOOL)containsIndexesInRange:(CTRange)aRange
{
    if (aRange.length <= 0)
        return NO;

    // If we have less total indexes than aRange, we can't possibly contain aRange.
    if (_count < aRange.length)
        return NO;

    // Search for first location
    var rangeIndex = positionOfIndex(_ranges, aRange.location);

    // If we don't have the first location, then we don't contain aRange.
    if (rangeIndex === -1)
        return NO;

    var range = _ranges[rangeIndex];

    // The intersection must contain all the indexes from the original range.
    return CTIntersectionRange(range, aRange).length === aRange.length;
}

- (BOOL)containsIndexes:(CTIndexSet)anIndexSet
{
    var otherCount = anIndexSet._count;

    if (otherCount <= 0)
        return YES;

    // If we have less total indexes than anIndexSet, we can't possibly contain aRange.
    if (_count < otherCount)
        return NO;

    var otherRanges = anIndexSet._ranges,
        otherRangesCount = otherRanges.length;

    while (otherRangesCount--)
        if (![self containsIndexesInRange:otherRanges[otherRangesCount]])
            return NO;

    return YES;
}

- (BOOL)intersectsIndexesInRange:(CTRange)aRange
{
    if (_count <= 0)
        return NO;

    var lhsRangeIndex = assumedPositionOfIndex(_ranges, aRange.location);

    if (FLOOR(lhsRangeIndex) === lhsRangeIndex)
        return YES;

    var rhsRangeIndex = assumedPositionOfIndex(_ranges, CTMaxRange(aRange) - 1);

    if (FLOOR(rhsRangeIndex) === rhsRangeIndex)
        return YES;

    return lhsRangeIndex !== rhsRangeIndex;
}

- (CTInteger)firstIndex
{
    if (_count > 0)
        return _ranges[0].location;

    return -1;
}

/*!
    Returns the last index in the set
*/
- (CTInteger)lastIndex
{
    if (_count > 0)
        return CTMaxRange(_ranges[_ranges.length - 1]) - 1;

    return -1;
}

- (Integer)indexGreaterThanIndex:(Integer)anIndex
{
    // The first possible index that would satisfy this requirement.
    ++anIndex;

    // Attempt to find it or something bigger.
    var rangeIndex = assumedPositionOfIndex(_ranges, anIndex);

    // Nothing at all found?
    if (rangeIndex === -1)
        return -1;

    rangeIndex = CEIL(rangeIndex);

    if (rangeIndex >= _ranges.length)
        return -1;

    var range = _ranges[rangeIndex];

    // Check if it's actually in this range.
    if (CTLocationInRange(anIndex, range))
        return anIndex;

    // If not, it must be the first element of this range.
    return range.location;
}

- (Integer)indexLessThanIndex:(Integer)anIndex
{
    // The first possible index that would satisfy this requirement.
    --anIndex;

    // Attempt to find it or something smaller.
    var rangeIndex = assumedPositionOfIndex(_ranges, anIndex);

    // Nothing at all found?
    if (rangeIndex === -1)
        return -1;

    rangeIndex = FLOOR(rangeIndex);

    if (rangeIndex < 0)
        return -1;

    var range = _ranges[rangeIndex];

    // Check if it's actually in this range.
    if (CTLocationInRange(anIndex, range))
        return anIndex;

    // If not, it must be the first element of this range.
    return CTMaxRange(range) - 1;
}

-(Integer) count {
    return _count; 
}

-(CTArray) getIndexesInRange:(CTRange)aRange {

    if(!_count || aRange && !aRange.length) {
        return [];
    }

    var total = 0;
    var anArray = [];

    if (aRange)
    {
        var firstIndex = aRange.location,
            lastIndex = CTMaxRange(aRange) - 1,
            rangeIndex = CEIL(assumedPositionOfIndex(_ranges, firstIndex)),
            lastRangeIndex = FLOOR(assumedPositionOfIndex(_ranges, lastIndex));
    }
    else
    {
        var firstIndex = [self firstIndex],
            lastIndex = [self lastIndex],
            rangeIndex = 0,
            lastRangeIndex = _ranges.length - 1;
    }

    while (rangeIndex <= lastRangeIndex)
    {
        var range = _ranges[rangeIndex],
            index = MAX(firstIndex, range.location),
            maxRange = MIN(lastIndex + 1, CTMaxRange(range));

        for (; index < maxRange; ++index)
        {
            anArray[total++] = index;
        }

        ++rangeIndex;
    }

    return anArray;
}


/** Adding Indexes **/
- (void)addIndexesInRange:(CTRange)aRange
{
    if (aRange.location < 0)
        throw new Error("Range " + CTStringFromRange(aRange) + " is out of bounds.");

    // If empty range, bail.
    if (aRange.length <= 0)
        return;

    // If we currently don't have any indexes, this represents our entire set.
    if (_count <= 0)
    {
        _count = aRange.length;
        _ranges = [aRange];
        return;
    }

    var rangeCount = _ranges.length,
        lhsRangeIndex = assumedPositionOfIndex(_ranges, aRange.location - 1),
        lhsRangeIndexCEIL = CEIL(lhsRangeIndex);

    if (lhsRangeIndexCEIL === lhsRangeIndex && lhsRangeIndexCEIL < rangeCount)
        aRange = CTUnionRange(aRange, _ranges[lhsRangeIndexCEIL]);

    var rhsRangeIndex = assumedPositionOfIndex(_ranges, CTMaxRange(aRange)),
        rhsRangeIndexFLOOR = FLOOR(rhsRangeIndex);

    if (rhsRangeIndexFLOOR === rhsRangeIndex && rhsRangeIndexFLOOR >= 0)
        aRange = CTUnionRange(aRange, _ranges[rhsRangeIndexFLOOR]);

    var removalCount = rhsRangeIndexFLOOR - lhsRangeIndexCEIL + 1;

    if (removalCount === _ranges.length)
    {
        _ranges = [aRange];
        _count = aRange.length;
    }

    else if (removalCount === 1)
    {
        if (lhsRangeIndexCEIL < _ranges.length)
            _count -= _ranges[lhsRangeIndexCEIL].length;

        _count += aRange.length;
        _ranges[lhsRangeIndexCEIL] = aRange;
    }
    else
    {
        if (removalCount > 0)
        {
            var removal = lhsRangeIndexCEIL,
                lastRemoval = lhsRangeIndexCEIL + removalCount - 1;

            for (; removal <= lastRemoval; ++removal)
                _count -= _ranges[removal].length;

            [_ranges removeObjectsInRange:CTMakeRange(lhsRangeIndexCEIL, removalCount)];
        }

        [_ranges insertObject:aRange atIndex:lhsRangeIndexCEIL];

        _count += aRange.length;
    }
}

- (void)addIndexes:(CTIndexSet)anIndexSet
{
    var otherRanges = anIndexSet._ranges,
        otherRangesCount = otherRanges.length;

    // Simply add each range within anIndexSet.
    while (otherRangesCount--)
        [self addIndexesInRange:otherRanges[otherRangesCount]];
}

- (void)addIndex:(Integer)anIndex
{
    [self addIndexesInRange:CTMakeRange(anIndex, 1)];
}

/** Removing Indexes **/

- (void)removeIndexesInRange:(CTRange)aRange
{
    // If empty range, bail.
    if (aRange.length <= 0)
        return;

    // If we currently don't have any indexes, there's nothing to remove.
    if (_count <= 0)
        return;

    var rangeCount = _ranges.length,
        lhsRangeIndex = assumedPositionOfIndex(_ranges, aRange.location),
        lhsRangeIndexCEIL = CEIL(lhsRangeIndex);

    // Do we fall on an actual existing range?
    if (lhsRangeIndex === lhsRangeIndexCEIL && lhsRangeIndexCEIL < rangeCount)
    {
        var existingRange = _ranges[lhsRangeIndexCEIL];

        // If these ranges don't start in the same place, we have to cull it.
        if (aRange.location !== existingRange.location)
        {
            var maxRange = CTMaxRange(aRange),
                existingMaxRange = CTMaxRange(existingRange);

            existingRange.length = aRange.location - existingRange.location;

            // If this range is internal to the existing range, we have a unique splitting case.
            if (maxRange < existingMaxRange)
            {
                _count -= aRange.length;
                [_ranges insertObject:CTMakeRange(maxRange, existingMaxRange - maxRange) atIndex:lhsRangeIndexCEIL + 1];

                return;
            }
            else
            {
                _count -= existingMaxRange - aRange.location;
                lhsRangeIndexCEIL += 1;
            }
        }
    }

    var rhsRangeIndex = assumedPositionOfIndex(_ranges, CTMaxRange(aRange) - 1),
        rhsRangeIndexFLOOR = FLOOR(rhsRangeIndex);

    if (rhsRangeIndex === rhsRangeIndexFLOOR && rhsRangeIndexFLOOR >= 0)
    {
        var maxRange = CTMaxRange(aRange),
            existingRange = _ranges[rhsRangeIndexFLOOR],
            existingMaxRange = CTMaxRange(existingRange);

        if (maxRange !== existingMaxRange)
        {
            _count -= maxRange - existingRange.location;
            rhsRangeIndexFLOOR -= 1; // This is accounted for, and thus as if we got the previous spot.

            existingRange.location = maxRange;
            existingRange.length = existingMaxRange - maxRange;
        }
    }

    var removalCount = rhsRangeIndexFLOOR - lhsRangeIndexCEIL + 1;

    if (removalCount > 0)
    {
        var removal = lhsRangeIndexCEIL,
            lastRemoval = lhsRangeIndexCEIL + removalCount - 1;

        for (; removal <= lastRemoval; ++removal)
            _count -= _ranges[removal].length;

        [_ranges removeObjectsInRange:CTMakeRange(lhsRangeIndexCEIL, removalCount)];
    }
}

- (void)removeIndex:(Integer)anIndex
{
    [self removeIndexesInRange:CTMakeRange(anIndex, 1)];
}

- (void)removeIndexes:(CTIndexSet)anIndexSet
{
    var otherRanges = anIndexSet._ranges,
        otherRangesCount = otherRanges.length;

    // Simply remove each index from anIndexSet
    while (otherRangesCount--)
        [self removeIndexesInRange:otherRanges[otherRangesCount]];
}

- (void)removeAllIndexes
{
    _ranges = [];
    _count = 0;
}

/** Shifting Indexes **/
- (void)shiftIndexesStartingAtIndex:(Integer)anIndex by:(Integer)aDelta
{
    if (!_count || aDelta == 0)
       return;

    // Later indexes have a higher probability of being shifted
    // than lower ones, so start at the end and work backwards.
    var i = _ranges.length - 1,
        shifted = CTMakeRange(-1, 0);

    for (; i >= 0; --i)
    {
        var range = _ranges[i],
            maximum = CTMaxRange(range);

        if (anIndex >= maximum)
            break;

        // If our index is within our range, but not the first index,
        // then this range will be split.
        if (anIndex > range.location)
        {
            // Split the range into shift and unshifted.
            shifted = CTMakeRange(anIndex + aDelta, maximum - anIndex);
            range.length = anIndex - range.location;

            // If our delta is positive, then we can simply add the range
            // to the array.
            if (aDelta > 0)
                [_ranges insertObject:shifted atIndex:i + 1];
            // If it's negative, it needs to be added properly later.
            else if (shifted.location < 0)
            {
                shifted.length = CTMaxRange(shifted);
                shifted.location = 0;
            }

            // We don't need to continue.
            break;
        }

        // Shift the range, and normalize it if the result is negative.
        if ((range.location += aDelta) < 0)
        {
            _count -= range.length - CTMaxRange(range);
            range.length = CTMaxRange(range);
            range.location = 0;
        }
    }

    // We need to add the shifted ranges if the delta is negative.
    if (aDelta < 0)
    {
        var j = i + 1,
            count = _ranges.length,
            shifts = [];

        for (; j < count; ++j)
        {
            [shifts addObject:_ranges[j]];
            _count -= _ranges[j].length;
        }

        if ((j = i + 1) < count)
        {
            [_ranges removeObjectsInRange:CTMakeRange(j, count - j)];

            for (j = 0, count = shifts.length; j < count; ++j)
                [self addIndexesInRange:shifts[j]];
        }

        if (shifted.location != -1)
            [self addIndexesInRange:shifted];
    }
}

@end

CTIndexSet.allocator.prototype[Symbol.iterator] = function() {
    let values = [this getIndexesInRange:nil];
    let index = 0;
    return {
        next() {
            if (index < values.length) {
                let val = values[index];
                index++;
                return { value: val, done: false };
             } else return { done: true };
        }
    }
};
