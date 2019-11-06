#!/bin/bash
#

set -e
set -u
shopt -s nullglob

# Utility functions

set_kernel_config() {
    # flag as $1, value to set as $2, config must exist at "./.config"
    local TGT="CONFIG_${1#CONFIG_}"
    local REP="${2//\//\\/}"
    if grep -q "^${TGT}[^_]" .config; then
        sed -i "s/^\(${TGT}=.*\|# ${TGT} is not set\)/${TGT}=${REP}/" .config
    else
        echo "${TGT}=${2}" >> .config
    fi
}

unset_kernel_config() {
    # unsets flag with the value of $1, config must exist at "./.config"
    local TGT="CONFIG_${1#CONFIG_}"
    sed -i "s/^${TGT}=.*/# ${TGT} is not set/" .config
}

# Custom config settings follow

# Ceph / RBD
set_kernel_config CONFIG_CEPH_FSCACHE y
set_kernel_config CONFIG_CEPH_FS m
set_kernel_config CONFIG_CEPH_FS_POSIX_ACL y
set_kernel_config CONFIG_CEPH_LIB m
set_kernel_config CONFIG_CEPH_LIB_USE_DNS_RESOLVER y
set_kernel_config CONFIG_CEPH_LIB_PRETTYDEBUG y
set_kernel_config CONFIG_FSCACHE m
set_kernel_config CONFIG_FSCACHE_STATS y
set_kernel_config CONFIG_LIBCRC32C m
set_kernel_config CONFIG_BLK_DEV_RBD m

# CPU bandwidth provisioning for FAIR_GROUP_SCHED
set_kernel_config CONFIG_CFS_BANDWIDTH y

# Stream parsing
set_kernel_config CONFIG_STREAM_PARSER y
set_kernel_config CONFIG_BPF_STREAM_PARSER y
set_kernel_config CONFIG_BPF_LIRC_MODE2 y

# XDP sockets
set_kernel_config CONFIG_XDP_SOCKETS y

# NF Tables / NAT settings
set_kernel_config CONFIG_NF_TABLES_INET y
set_kernel_config CONFIG_NF_TABLES_IPV4 y
set_kernel_config CONFIG_NF_TABLES_IPV6 y
set_kernel_config CONFIG_NF_TABLES_NETDEV y
set_kernel_config CONFIG_NF_TABLES_ARP y
set_kernel_config CONFIG_NF_TABLES_BRIDGE y
set_kernel_config CONFIG_NF_NAT_MASQUERADE_IPV4 y
set_kernel_config CONFIG_NF_NAT_MASQUERADE_IPV6 y
set_kernel_config CONFIG_NF_NAT_REDIRECT y

# Enable ARM kernel workarounds
set_kernel_config CONFIG_ARM64_WORKAROUND_CLEAN_CACHE y
set_kernel_config CONFIG_ARM64_WORKAROUND_REPEAT_TLBI y
set_kernel_config CONFIG_ARM64_ERRATUM_834220 y
set_kernel_config CONFIG_ARM64_ERRATUM_1418040 y
set_kernel_config CONFIG_ARM64_ERRATUM_1165522 y
set_kernel_config CONFIG_ARM64_ERRATUM_1286807 y

# Default power mode
unset_kernel_config CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE
set_kernel_config CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND y

# HDMI CRC
set_kernel_config CONFIG_MEDIA_CEC_RC n
set_kernel_config SMS_SIANO_RC n

# Enable kernel audit
set_kernel_config CONFIG_AUDIT y
set_kernel_config CONFIG_HAVE_ARCH_AUDITSYSCALL y
set_kernel_config CONFIG_AUDITSYSCALL y
set_kernel_config CONFIG_NETFILTER_XT_TARGET_AUDIT m

# Enable YAMA/Ptrace
set_kernel_config CONFIG_SECURITY_YAMA y

# Crypto
set_kernel_config CONFIG_CRYPTO_ENGINE m
set_kernel_config CONFIG_CRYPTO_SHA256_ARM64 m
set_kernel_config CONFIG_CRYPTO_SHA512_ARM64 m
set_kernel_config CONFIG_CRYPTO_SHA1_ARM64_CE m
set_kernel_config CONFIG_CRYPTO_SHA2_ARM64_CE m
set_kernel_config CONFIG_CRYPTO_GHASH_ARM64_CE m
set_kernel_config CONFIG_CRYPTO_CRCT10DIF_ARM64_CE m
set_kernel_config CONFIG_CRYPTO_AES_ARM64_CE m
set_kernel_config CONFIG_CRYPTO_AES_ARM64_CE_CCM m
set_kernel_config CONFIG_CRYPTO_AES_ARM64_CE_BLK m
set_kernel_config CONFIG_CRYPTO_CHACHA20_NEON m

# Security
set_kernel_config CONFIG_PERSISTENT_KEYRINGS y
set_kernel_config CONFIG_BIG_KEYS y
set_kernel_config CONFIG_TRUSTED_KEYS y
set_kernel_config CONFIG_ENCRYPTED_KEYS y
set_kernel_config CONFIG_SECURITY y
set_kernel_config CONFIG_IP_NF_SECURITY m
set_kernel_config CONFIG_IP6_NF_SECURITY m
set_kernel_config CONFIG_FANOTIFY_ACCESS_PERMISSIONS y
set_kernel_config CONFIG_NFSD_V4_SECURITY_LABEL y
set_kernel_config CONFIG_SECURITY_NETWORK y
set_kernel_config CONFIG_SECURITY_NETWORK_XFRM y
set_kernel_config CONFIG_SECURITY_PATH y
set_kernel_config CONFIG_SECURITY_SELINUX y
set_kernel_config CONFIG_SECURITY_SELINUX_BOOTPARAM y
set_kernel_config CONFIG_SECURITY_SELINUX_DISABLE y
set_kernel_config CONFIG_SECURITY_SELINUX_DEVELOP y
set_kernel_config CONFIG_SECURITY_SELINUX_AVC_STATS y
set_kernel_config CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE 0
set_kernel_config CONFIG_SECURITY_APPARMOR y
set_kernel_config CONFIG_SECURITY_APPARMOR_BOOTVALUE 1
set_kernel_config CONFIG_SECURITY_APPARMOR_HASH y
set_kernel_config CONFIG_SECURITY_APPARMOR_HASH_DEFAULT y
set_kernel_config CONFIG_SECURITY_APPARMOR_DEBUG n
set_kernel_config CONFIG_SECURITY_LOADPIN n
set_kernel_config CONFIG_INTEGRITY n

# Performance
set_kernel_config CONFIG_ARM64_PMEM y
set_kernel_config CONFIG_CGROUP_PERF y
set_kernel_config CONFIG_ARM64_CNP y
set_kernel_config CONFIG_ARM64_PTR_AUTH y
set_kernel_config CONFIG_ARM64_PSEUDO_NMI y
set_kernel_config CONFIG_RELOCATABLE y
set_kernel_config CONFIG_RANDOMIZE_BASE y
set_kernel_config CONFIG_RANDOMIZE_MODULE_REGION_FULL y
set_kernel_config CONFIG_CC_HAVE_STACKPROTECTOR_SYSREG y
set_kernel_config CONFIG_STACKPROTECTOR_PER_TASK y
set_kernel_config CONFIG_ARCH_INLINE_SPIN_TRYLOCK y
set_kernel_config CONFIG_ARCH_INLINE_SPIN_TRYLOCK_BH y
set_kernel_config CONFIG_ARCH_INLINE_SPIN_LOCK y
set_kernel_config CONFIG_ARCH_INLINE_SPIN_LOCK_BH y
set_kernel_config CONFIG_ARCH_INLINE_SPIN_LOCK_IRQ y
set_kernel_config CONFIG_ARCH_INLINE_SPIN_LOCK_IRQSAVE y
set_kernel_config CONFIG_ARCH_INLINE_SPIN_UNLOCK y
set_kernel_config CONFIG_ARCH_INLINE_SPIN_UNLOCK_BH y
set_kernel_config CONFIG_ARCH_INLINE_SPIN_UNLOCK_IRQ y
set_kernel_config CONFIG_ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE y
set_kernel_config CONFIG_ARCH_INLINE_READ_LOCK y
set_kernel_config CONFIG_ARCH_INLINE_READ_LOCK_BH y
set_kernel_config CONFIG_ARCH_INLINE_READ_LOCK_IRQ y
set_kernel_config CONFIG_ARCH_INLINE_READ_LOCK_IRQSAVE y
set_kernel_config CONFIG_ARCH_INLINE_READ_UNLOCK y
set_kernel_config CONFIG_ARCH_INLINE_READ_UNLOCK_BH y
set_kernel_config CONFIG_ARCH_INLINE_READ_UNLOCK_IRQ y
set_kernel_config CONFIG_ARCH_INLINE_READ_UNLOCK_IRQRESTORE y
set_kernel_config CONFIG_ARCH_INLINE_WRITE_LOCK y
set_kernel_config CONFIG_ARCH_INLINE_WRITE_LOCK_BH y
set_kernel_config CONFIG_ARCH_INLINE_WRITE_LOCK_IRQ y
set_kernel_config CONFIG_ARCH_INLINE_WRITE_LOCK_IRQSAVE y
set_kernel_config CONFIG_ARCH_INLINE_WRITE_UNLOCK y
set_kernel_config CONFIG_ARCH_INLINE_WRITE_UNLOCK_BH y
set_kernel_config CONFIG_ARCH_INLINE_WRITE_UNLOCK_IRQ y
set_kernel_config CONFIG_ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE y
set_kernel_config CONFIG_INLINE_SPIN_TRYLOCK y
set_kernel_config CONFIG_INLINE_SPIN_TRYLOCK_BH y
set_kernel_config CONFIG_INLINE_SPIN_LOCK y
set_kernel_config CONFIG_INLINE_SPIN_LOCK_BH y
set_kernel_config CONFIG_INLINE_SPIN_LOCK_IRQ y
set_kernel_config CONFIG_INLINE_SPIN_LOCK_IRQSAVE y
set_kernel_config CONFIG_INLINE_SPIN_UNLOCK_BH y
set_kernel_config CONFIG_INLINE_SPIN_UNLOCK_IRQ y
set_kernel_config CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE y
set_kernel_config CONFIG_INLINE_READ_LOCK y
set_kernel_config CONFIG_INLINE_READ_LOCK_BH y
set_kernel_config CONFIG_INLINE_READ_LOCK_IRQ y
set_kernel_config CONFIG_INLINE_READ_LOCK_IRQSAVE y
set_kernel_config CONFIG_INLINE_READ_UNLOCK y
set_kernel_config CONFIG_INLINE_READ_UNLOCK_BH y
set_kernel_config CONFIG_INLINE_READ_UNLOCK_IRQ y
set_kernel_config CONFIG_INLINE_READ_UNLOCK_IRQRESTORE y
set_kernel_config CONFIG_INLINE_WRITE_LOCK y
set_kernel_config CONFIG_INLINE_WRITE_LOCK_BH y
set_kernel_config CONFIG_INLINE_WRITE_LOCK_IRQ y
set_kernel_config CONFIG_INLINE_WRITE_LOCK_IRQSAVE y
set_kernel_config CONFIG_INLINE_WRITE_UNLOCK y
set_kernel_config CONFIG_INLINE_WRITE_UNLOCK_BH y
set_kernel_config CONFIG_INLINE_WRITE_UNLOCK_IRQ y
set_kernel_config CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE y

# Memory
set_kernel_config CONFIG_HAVE_FAST_GUP y
set_kernel_config CONFIG_ARCH_KEEP_MEMBLOCK y

# VHOST
set_kernel_config CONFIG_VHOST_SCSI m
set_kernel_config CONFIG_VHOST_VSOCK m

# General
set_kernel_config CONFIG_64BIT_TIME y
set_kernel_config CONFIG_MTD_PCI m

# Sockets
set_kernel_config CONFIG_VSOCKETS m
set_kernel_config CONFIG_VSOCKETS_DIAG m
set_kernel_config CONFIG_VIRTIO_VSOCKETS m
set_kernel_config CONFIG_VIRTIO_VSOCKETS_COMMON m
set_kernel_config CONFIG_VIRTIO_BLK m

# Networking
set_kernel_config CONFIG_NETLABEL y
set_kernel_config CONFIG_TCP_MD5SIG y
set_kernel_config CONFIG_TLS m
set_kernel_config CONFIG_TLS_DEVICE y
set_kernel_config CONFIG_INET_UDP_DIAG m
set_kernel_config CONFIG_INET_RAW_DIAG m
set_kernel_config CONFIG_INET_DIAG_DESTROY y
set_kernel_config CONFIG_NF_NAT_MASQUERADE y
set_kernel_config CONFIG_NETFILTER_SYNPROXY m
set_kernel_config CONFIG_NFT_XFRM m
set_kernel_config CONFIG_NF_CONNTRACK_SECMARK y
set_kernel_config CONFIG_NETFILTER_XT_TARGET_CONNSECMARK m
set_kernel_config CONFIG_NETFILTER_XT_TARGET_SECMARK m
set_kernel_config CONFIG_VSOCKMON m
set_kernel_config CONFIG_LSM_MMAP_MIN_ADDR 0

# Compiler options
set_kernel_config CONFIG_OPTIMIZE_INLINING y