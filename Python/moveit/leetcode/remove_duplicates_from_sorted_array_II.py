def removeDuplicates(nums):
    if(len(nums)<2):
        return len(nums)
    lent = 2
    for i in xrange(2,len(nums)):
        if nums[i] != nums[lent-2]:
            nums[lent] = nums[i]
            lent+=1
    print(nums[:8])
    return lent

print(removeDuplicates([1,1,1,2,2,1,1,1,3,3,3]))
