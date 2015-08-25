class Solution:
    #@param {interger} n
    #@return {interger} n
    def countPrimes(self,n):
        if n < 2:
            return 0
        isPrime=[True]*n
        isPrime[0]=isPrime[1] = False
        for i in range(2,int(n**0.5)):
            isPrime[i*i:n:i] = [False]*len(isPrime[i*i:n:i])
        return sum(isPrime)

test = Solution()
print(test.countPrimes(10000000))
