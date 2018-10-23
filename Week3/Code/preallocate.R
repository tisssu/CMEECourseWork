# This script is to compare the system time between using pre-allocation and not
# Author Wang YuHeng


# not preallocate the a
a <- NA
system.time(for (i in 1:100000) {a <- c(a, i)})
print(a)



#preallocate the a
a <- rep(NA, 1000000)
system.time(for (i in 1:1000000) {a[i] <- i})
print(a)