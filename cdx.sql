-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.6.26 - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win32
-- HeidiSQL 版本:                  9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出 cdx 的数据库结构
CREATE DATABASE IF NOT EXISTS `cdx` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `cdx`;


-- 导出  表 cdx.cu_gongchang 结构
CREATE TABLE IF NOT EXISTS `cu_gongchang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0' COMMENT '产物名称',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0无工作 1生产中 2不可使用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  cdx.cu_gongchang 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cu_gongchang` DISABLE KEYS */;
/*!40000 ALTER TABLE `cu_gongchang` ENABLE KEYS */;


-- 导出  表 cdx.cu_job 结构
CREATE TABLE IF NOT EXISTS `cu_job` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0' COMMENT '职位名称',
  `list` int(11) NOT NULL DEFAULT '0' COMMENT '职位优先级',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  cdx.cu_job 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cu_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `cu_job` ENABLE KEYS */;


-- 导出  表 cdx.cu_kucun 结构
CREATE TABLE IF NOT EXISTS `cu_kucun` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0' COMMENT '名字',
  `util` varchar(50) NOT NULL DEFAULT '0' COMMENT '单位',
  `num` int(11) NOT NULL DEFAULT '0' COMMENT '个数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  cdx.cu_kucun 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cu_kucun` DISABLE KEYS */;
/*!40000 ALTER TABLE `cu_kucun` ENABLE KEYS */;


-- 导出  表 cdx.cu_kucun_dingdan 结构
CREATE TABLE IF NOT EXISTS `cu_kucun_dingdan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0' COMMENT '名字',
  `util` varchar(50) NOT NULL DEFAULT '0' COMMENT '单位',
  `dateline` int(11) NOT NULL DEFAULT '0' COMMENT '时间戳',
  `num` int(11) NOT NULL DEFAULT '0' COMMENT '个数',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '0进货 1出货',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0未审核 1已通过 2已拒绝',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  cdx.cu_kucun_dingdan 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cu_kucun_dingdan` DISABLE KEYS */;
/*!40000 ALTER TABLE `cu_kucun_dingdan` ENABLE KEYS */;


-- 导出  表 cdx.cu_shengchan_dingdan 结构
CREATE TABLE IF NOT EXISTS `cu_shengchan_dingdan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0' COMMENT '生产物名称',
  `gongchang` varchar(50) NOT NULL DEFAULT '0' COMMENT '负责工厂',
  `people` varchar(50) NOT NULL DEFAULT '0' COMMENT '负责人',
  `num` varchar(50) NOT NULL DEFAULT '0' COMMENT '预计生产数量',
  `submit_num` varchar(50) NOT NULL DEFAULT '0' COMMENT '实际生产数量',
  `util` varchar(50) NOT NULL DEFAULT '0' COMMENT '单位',
  `dateline` int(11) NOT NULL DEFAULT '0' COMMENT '订单创建时间戳',
  `submit_dateline` int(11) NOT NULL DEFAULT '0' COMMENT '生产完成时间戳',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  cdx.cu_shengchan_dingdan 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cu_shengchan_dingdan` DISABLE KEYS */;
/*!40000 ALTER TABLE `cu_shengchan_dingdan` ENABLE KEYS */;


-- 导出  表 cdx.cu_shengchan_log 结构
CREATE TABLE IF NOT EXISTS `cu_shengchan_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(1000) NOT NULL DEFAULT '0' COMMENT '日志内容',
  `dateline` varchar(1000) NOT NULL DEFAULT '0' COMMENT '日志创建时间',
  `sid` varchar(1000) NOT NULL DEFAULT '0' COMMENT 'shengchan_dingdan的id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  cdx.cu_shengchan_log 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cu_shengchan_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `cu_shengchan_log` ENABLE KEYS */;


-- 导出  表 cdx.cu_user 结构
CREATE TABLE IF NOT EXISTS `cu_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL DEFAULT '0',
  `password` varchar(50) NOT NULL DEFAULT '0',
  `name` varchar(40) NOT NULL DEFAULT '0',
  `sal` int(11) NOT NULL DEFAULT '0',
  `sex` varchar(10) NOT NULL DEFAULT '0',
  `dateline` int(11) NOT NULL DEFAULT '0',
  `job` varchar(20) NOT NULL DEFAULT '0' COMMENT '职位名称',
  `list` int(11) NOT NULL DEFAULT '0' COMMENT '职位优先级',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0无工作 1工作中',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  cdx.cu_user 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cu_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `cu_user` ENABLE KEYS */;


-- 导出  表 cdx.cu_wuliu_dingdan 结构
CREATE TABLE IF NOT EXISTS `cu_wuliu_dingdan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` int(11) NOT NULL DEFAULT '0' COMMENT '送货名称',
  `util` int(11) NOT NULL DEFAULT '0' COMMENT '单位',
  `dateline` int(11) NOT NULL DEFAULT '0' COMMENT '时间戳',
  `num` int(11) NOT NULL DEFAULT '0' COMMENT '个数',
  `money` int(11) NOT NULL DEFAULT '0' COMMENT '总价',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0未审核 1通过 2拒绝',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  cdx.cu_wuliu_dingdan 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `cu_wuliu_dingdan` DISABLE KEYS */;
/*!40000 ALTER TABLE `cu_wuliu_dingdan` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
