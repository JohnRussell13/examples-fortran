# ORIGINAL LINK https://gist.github.com/SomajitDey/aeb6eb4c8083185e06800e1ece4be1bd

- [Official Guide](https://www.intel.com/content/www/us/en/develop/documentation/installation-guide-for-intel-oneapi-toolkits-linux/top/installation/install-using-package-managers/apt.html)
- [VMagnin's post](https://fortran-lang.discourse.group/t/intel-releases-oneapi-toolkit-free-fortran-2018/471/43)
- **NOTE**: Make sure to do `sudo apt update` after adding intel's repositories to apt.
- [VMagnin's post regarding sourcing `/opt/intel/oneapi/setvars.sh`](https://fortran-lang.discourse.group/t/intel-releases-oneapi-toolkit-free-fortran-2018/471/74)
- [Another useful source](https://oneapi-src.github.io/oneapi-ci/)

My route:
1. `curl -Lo- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB | sudo gpg --dearmor -o /usr/share/keyrings/oneapi-archive-keyring.gpg`
2. `sudo tee /etc/apt/sources.list.d/oneAPI.list <<< "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main"`
3. `sudo apt update`
4. `sudo apt install intel-oneapi-compiler-fortran`
5. Optional: `sudo apt install intel-oneapi-mkl`
6. In `~/.bashrc`: `source /opt/intel/oneapi/setvars.sh > /dev/null`
