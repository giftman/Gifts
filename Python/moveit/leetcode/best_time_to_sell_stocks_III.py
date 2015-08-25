class Solution:
    def maxProfit(self,prices):
        minLV = 65525
        maxV = diff = 0
        maxFromLeft = maxFromRight = []
        for i in range(len(prices)):
            if minLV > prices[i]: minLV = prices[i]
            diff = prices[i] - minLV
            if diff > maxV: maxV = diff
            maxFromLeft.append(maxV)
        maxRV = 0
        maxV = diff = 0
        for i in range(len(prices))[::-1]:
            if maxRV < prices[i]: maxRV = prices[i]
            diff =  maxRV - prices[i]
            if diff > maxV: maxV = diff
            maxFromRight.appendleft(maxV)
        maxProfit = 0
        print(maxFromLeft,maxFromRight)
        for i in range(len(prices)):
            sum = maxFromLeft[i] + maxFromRight[i+1]
            if sum > maxProfit: maxProfit = sum
        if maxProfit < maxFromRight[0]:
            maxProfit = maxFromRight
        return maxProfit

test = Solution()
print(test.maxProfit([6,1,2,3,4,7]))

