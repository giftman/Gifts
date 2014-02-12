--table vs object ?
Account = {balance = 0}
--[[
function Account.withdraw (v)
    Account.balance = Account.balance -v
end

--Account.withdraw(100.00)
a = Account;
Account = nil
a.withdraw(100.00)
print(Account.balance)
]]
--up methods use a global value "Account" in its own...its not a good idea.
function Account.withdraw(self,v)
    self.balance = self.balance -v
end

a = Account;
Account = nil
a.withdraw(a,100.00)
print(a.balance)

