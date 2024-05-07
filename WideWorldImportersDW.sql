USE [master]
GO
/****** Object:  Database [WideWorldImportersDW]    Script Date: 2024/05/01 18:49:22 ******/
CREATE DATABASE [WideWorldImportersDW]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WWI_Primary', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\WideWorldImportersDW.mdf' , SIZE = 2097152KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
 FILEGROUP [USERDATA]  DEFAULT
( NAME = N'WWI_UserData', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\WideWorldImportersDW_UserData.ndf' , SIZE = 2097152KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
 FILEGROUP [WWIDW_InMemory_Data] CONTAINS MEMORY_OPTIMIZED_DATA  DEFAULT
( NAME = N'WWIDW_InMemory_Data_1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\WideWorldImportersDW_InMemory_Data_1' , MAXSIZE = UNLIMITED)
 LOG ON 
( NAME = N'WWI_Log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\WideWorldImportersDW.ldf' , SIZE = 102400KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [WideWorldImportersDW] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WideWorldImportersDW].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WideWorldImportersDW] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WideWorldImportersDW] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WideWorldImportersDW] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WideWorldImportersDW] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WideWorldImportersDW] SET ARITHABORT OFF 
GO
ALTER DATABASE [WideWorldImportersDW] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WideWorldImportersDW] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WideWorldImportersDW] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WideWorldImportersDW] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WideWorldImportersDW] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WideWorldImportersDW] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WideWorldImportersDW] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WideWorldImportersDW] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WideWorldImportersDW] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WideWorldImportersDW] SET  DISABLE_BROKER 
GO
ALTER DATABASE [WideWorldImportersDW] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WideWorldImportersDW] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WideWorldImportersDW] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WideWorldImportersDW] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WideWorldImportersDW] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WideWorldImportersDW] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WideWorldImportersDW] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WideWorldImportersDW] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [WideWorldImportersDW] SET  MULTI_USER 
GO
ALTER DATABASE [WideWorldImportersDW] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WideWorldImportersDW] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WideWorldImportersDW] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WideWorldImportersDW] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [WideWorldImportersDW] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [WideWorldImportersDW] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'WideWorldImportersDW', N'ON'
GO
ALTER DATABASE [WideWorldImportersDW] SET QUERY_STORE = ON
GO
ALTER DATABASE [WideWorldImportersDW] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 3000, INTERVAL_LENGTH_MINUTES = 15, MAX_STORAGE_SIZE_MB = 500, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 1000, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [WideWorldImportersDW]
GO
/****** Object:  Schema [Application]    Script Date: 2024/05/01 18:49:23 ******/
CREATE SCHEMA [Application]
GO
/****** Object:  Schema [Dimension]    Script Date: 2024/05/01 18:49:23 ******/
CREATE SCHEMA [Dimension]
GO
/****** Object:  Schema [Fact]    Script Date: 2024/05/01 18:49:23 ******/
CREATE SCHEMA [Fact]
GO
/****** Object:  Schema [Integration]    Script Date: 2024/05/01 18:49:23 ******/
CREATE SCHEMA [Integration]
GO
/****** Object:  Schema [PowerBI]    Script Date: 2024/05/01 18:49:23 ******/
CREATE SCHEMA [PowerBI]
GO
/****** Object:  Schema [Reports]    Script Date: 2024/05/01 18:49:23 ******/
CREATE SCHEMA [Reports]
GO
/****** Object:  Schema [Sequences]    Script Date: 2024/05/01 18:49:23 ******/
CREATE SCHEMA [Sequences]
GO
/****** Object:  Schema [Website]    Script Date: 2024/05/01 18:49:23 ******/
CREATE SCHEMA [Website]
GO
/****** Object:  PartitionFunction [PF_Date]    Script Date: 2024/05/01 18:49:23 ******/
CREATE PARTITION FUNCTION [PF_Date](date) AS RANGE RIGHT FOR VALUES (N'2012-01-01T00:00:00.000', N'2013-01-01T00:00:00.000', N'2014-01-01T00:00:00.000', N'2015-01-01T00:00:00.000', N'2016-01-01T00:00:00.000', N'2017-01-01T00:00:00.000')
GO
/****** Object:  PartitionScheme [PS_Date]    Script Date: 2024/05/01 18:49:23 ******/
CREATE PARTITION SCHEME [PS_Date] AS PARTITION [PF_Date] TO ([USERDATA], [USERDATA], [USERDATA], [USERDATA], [USERDATA], [USERDATA], [USERDATA], [USERDATA])
GO
USE [WideWorldImportersDW]
GO
/****** Object:  Sequence [Sequences].[CityKey]    Script Date: 2024/05/01 18:49:23 ******/
CREATE SEQUENCE [Sequences].[CityKey] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE 
GO
USE [WideWorldImportersDW]
GO
/****** Object:  Sequence [Sequences].[CustomerKey]    Script Date: 2024/05/01 18:49:23 ******/
CREATE SEQUENCE [Sequences].[CustomerKey] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE 
GO
USE [WideWorldImportersDW]
GO
/****** Object:  Sequence [Sequences].[EmployeeKey]    Script Date: 2024/05/01 18:49:23 ******/
CREATE SEQUENCE [Sequences].[EmployeeKey] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE 
GO
USE [WideWorldImportersDW]
GO
/****** Object:  Sequence [Sequences].[LineageKey]    Script Date: 2024/05/01 18:49:23 ******/
CREATE SEQUENCE [Sequences].[LineageKey] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE 
GO
USE [WideWorldImportersDW]
GO
/****** Object:  Sequence [Sequences].[PaymentMethodKey]    Script Date: 2024/05/01 18:49:23 ******/
CREATE SEQUENCE [Sequences].[PaymentMethodKey] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE 
GO
USE [WideWorldImportersDW]
GO
/****** Object:  Sequence [Sequences].[StockItemKey]    Script Date: 2024/05/01 18:49:23 ******/
CREATE SEQUENCE [Sequences].[StockItemKey] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE 
GO
USE [WideWorldImportersDW]
GO
/****** Object:  Sequence [Sequences].[SupplierKey]    Script Date: 2024/05/01 18:49:23 ******/
CREATE SEQUENCE [Sequences].[SupplierKey] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE 
GO
USE [WideWorldImportersDW]
GO
/****** Object:  Sequence [Sequences].[TransactionTypeKey]    Script Date: 2024/05/01 18:49:23 ******/
CREATE SEQUENCE [Sequences].[TransactionTypeKey] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE 
GO
/****** Object:  UserDefinedFunction [Integration].[GenerateDateDimensionColumns]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [Integration].[GenerateDateDimensionColumns](@Date date)
RETURNS TABLE
AS
RETURN SELECT @Date AS [Date],
              DAY(@Date) AS [Day Number],
              CAST(DATENAME(day, @Date) AS nvarchar(10)) AS [Day],
              CAST(DATENAME(month, @Date) AS nvarchar(10)) AS [Month],
              CAST(SUBSTRING(DATENAME(month, @Date), 1, 3) AS nvarchar(3)) AS [Short Month],
              MONTH(@Date) AS [Calendar Month Number],
              CAST(N'CY' + CAST(YEAR(@Date) AS nvarchar(4)) + N'-' + SUBSTRING(DATENAME(month, @Date), 1, 3) AS nvarchar(10)) AS [Calendar Month Label],
              YEAR(@Date) AS [Calendar Year],
              CAST(N'CY' + CAST(YEAR(@Date) AS nvarchar(4)) AS nvarchar(10)) AS [Calendar Year Label],
              CASE WHEN MONTH(@Date) IN (11, 12)
                   THEN MONTH(@Date) - 10
                   ELSE MONTH(@Date) + 2
              END AS [Fiscal Month Number],
              CAST(N'FY' + CAST(CASE WHEN MONTH(@Date) IN (11, 12)
                                     THEN YEAR(@Date) + 1
                                     ELSE YEAR(@Date)
                                END AS nvarchar(4)) + N'-' + SUBSTRING(DATENAME(month, @Date), 1, 3) AS nvarchar(20)) AS [Fiscal Month Label],
              CASE WHEN MONTH(@Date) IN (11, 12)
                   THEN YEAR(@Date) + 1
                   ELSE YEAR(@Date)
              END AS [Fiscal Year],
              CAST(N'FY' + CAST(CASE WHEN MONTH(@Date) IN (11, 12)
                                     THEN YEAR(@Date) + 1
                                     ELSE YEAR(@Date)
                                END AS nvarchar(4)) AS nvarchar(10)) AS [Fiscal Year Label],
              DATEPART(ISO_WEEK, @Date) AS [ISO Week Number];
GO
/****** Object:  Table [Dimension].[City]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Dimension].[City](
	[City Key] [int] NOT NULL,
	[WWI City ID] [int] NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[State Province] [nvarchar](50) NOT NULL,
	[Country] [nvarchar](60) NOT NULL,
	[Continent] [nvarchar](30) NOT NULL,
	[Sales Territory] [nvarchar](50) NOT NULL,
	[Region] [nvarchar](30) NOT NULL,
	[Subregion] [nvarchar](30) NOT NULL,
	[Location] [geography] NULL,
	[Latest Recorded Population] [bigint] NOT NULL,
	[Valid From] [datetime2](7) NOT NULL,
	[Valid To] [datetime2](7) NOT NULL,
	[Lineage Key] [int] NOT NULL,
 CONSTRAINT [PK_Dimension_City] PRIMARY KEY CLUSTERED 
(
	[City Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [USERDATA]
) ON [USERDATA] TEXTIMAGE_ON [USERDATA]
GO
/****** Object:  Table [Dimension].[Customer]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Dimension].[Customer](
	[Customer Key] [int] NOT NULL,
	[WWI Customer ID] [int] NOT NULL,
	[Customer] [nvarchar](100) NOT NULL,
	[Bill To Customer] [nvarchar](100) NOT NULL,
	[Category] [nvarchar](50) NOT NULL,
	[Buying Group] [nvarchar](50) NOT NULL,
	[Primary Contact] [nvarchar](50) NOT NULL,
	[Postal Code] [nvarchar](10) NOT NULL,
	[Valid From] [datetime2](7) NOT NULL,
	[Valid To] [datetime2](7) NOT NULL,
	[Lineage Key] [int] NOT NULL,
 CONSTRAINT [PK_Dimension_Customer] PRIMARY KEY CLUSTERED 
(
	[Customer Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [USERDATA]
) ON [USERDATA]
GO
/****** Object:  Table [Dimension].[Date]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Dimension].[Date](
	[Date] [date] NOT NULL,
	[Day Number] [int] NOT NULL,
	[Day] [nvarchar](10) NOT NULL,
	[Month] [nvarchar](10) NOT NULL,
	[Short Month] [nvarchar](3) NOT NULL,
	[Calendar Month Number] [int] NOT NULL,
	[Calendar Month Label] [nvarchar](20) NOT NULL,
	[Calendar Year] [int] NOT NULL,
	[Calendar Year Label] [nvarchar](10) NOT NULL,
	[Fiscal Month Number] [int] NOT NULL,
	[Fiscal Month Label] [nvarchar](20) NOT NULL,
	[Fiscal Year] [int] NOT NULL,
	[Fiscal Year Label] [nvarchar](10) NOT NULL,
	[ISO Week Number] [int] NOT NULL,
 CONSTRAINT [PK_Dimension_Date] PRIMARY KEY CLUSTERED 
(
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [USERDATA]
) ON [USERDATA]
GO
/****** Object:  Table [Dimension].[Employee]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Dimension].[Employee](
	[Employee Key] [int] NOT NULL,
	[WWI Employee ID] [int] NOT NULL,
	[Employee] [nvarchar](50) NOT NULL,
	[Preferred Name] [nvarchar](50) NOT NULL,
	[Is Salesperson] [bit] NOT NULL,
	[Photo] [varbinary](max) NULL,
	[Valid From] [datetime2](7) NOT NULL,
	[Valid To] [datetime2](7) NOT NULL,
	[Lineage Key] [int] NOT NULL,
 CONSTRAINT [PK_Dimension_Employee] PRIMARY KEY CLUSTERED 
(
	[Employee Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [USERDATA]
) ON [USERDATA] TEXTIMAGE_ON [USERDATA]
GO
/****** Object:  Table [Dimension].[Payment Method]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Dimension].[Payment Method](
	[Payment Method Key] [int] NOT NULL,
	[WWI Payment Method ID] [int] NOT NULL,
	[Payment Method] [nvarchar](50) NOT NULL,
	[Valid From] [datetime2](7) NOT NULL,
	[Valid To] [datetime2](7) NOT NULL,
	[Lineage Key] [int] NOT NULL,
 CONSTRAINT [PK_Dimension_Payment_Method] PRIMARY KEY CLUSTERED 
(
	[Payment Method Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [USERDATA]
) ON [USERDATA]
GO
/****** Object:  Table [Dimension].[Stock Item]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Dimension].[Stock Item](
	[Stock Item Key] [int] NOT NULL,
	[WWI Stock Item ID] [int] NOT NULL,
	[Stock Item] [nvarchar](100) NOT NULL,
	[Color] [nvarchar](20) NOT NULL,
	[Selling Package] [nvarchar](50) NOT NULL,
	[Buying Package] [nvarchar](50) NOT NULL,
	[Brand] [nvarchar](50) NOT NULL,
	[Size] [nvarchar](20) NOT NULL,
	[Lead Time Days] [int] NOT NULL,
	[Quantity Per Outer] [int] NOT NULL,
	[Is Chiller Stock] [bit] NOT NULL,
	[Barcode] [nvarchar](50) NULL,
	[Tax Rate] [decimal](18, 3) NOT NULL,
	[Unit Price] [decimal](18, 2) NOT NULL,
	[Recommended Retail Price] [decimal](18, 2) NULL,
	[Typical Weight Per Unit] [decimal](18, 3) NOT NULL,
	[Photo] [varbinary](max) NULL,
	[Valid From] [datetime2](7) NOT NULL,
	[Valid To] [datetime2](7) NOT NULL,
	[Lineage Key] [int] NOT NULL,
 CONSTRAINT [PK_Dimension_Stock_Item] PRIMARY KEY CLUSTERED 
(
	[Stock Item Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [USERDATA]
) ON [USERDATA] TEXTIMAGE_ON [USERDATA]
GO
/****** Object:  Table [Dimension].[Supplier]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Dimension].[Supplier](
	[Supplier Key] [int] NOT NULL,
	[WWI Supplier ID] [int] NOT NULL,
	[Supplier] [nvarchar](100) NOT NULL,
	[Category] [nvarchar](50) NOT NULL,
	[Primary Contact] [nvarchar](50) NOT NULL,
	[Supplier Reference] [nvarchar](20) NULL,
	[Payment Days] [int] NOT NULL,
	[Postal Code] [nvarchar](10) NOT NULL,
	[Valid From] [datetime2](7) NOT NULL,
	[Valid To] [datetime2](7) NOT NULL,
	[Lineage Key] [int] NOT NULL,
 CONSTRAINT [PK_Dimension_Supplier] PRIMARY KEY CLUSTERED 
(
	[Supplier Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [USERDATA]
) ON [USERDATA]
GO
/****** Object:  Table [Dimension].[Transaction Type]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Dimension].[Transaction Type](
	[Transaction Type Key] [int] NOT NULL,
	[WWI Transaction Type ID] [int] NOT NULL,
	[Transaction Type] [nvarchar](50) NOT NULL,
	[Valid From] [datetime2](7) NOT NULL,
	[Valid To] [datetime2](7) NOT NULL,
	[Lineage Key] [int] NOT NULL,
 CONSTRAINT [PK_Dimension_Transaction_Type] PRIMARY KEY CLUSTERED 
(
	[Transaction Type Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [USERDATA]
) ON [USERDATA]
GO
/****** Object:  Table [Fact].[Movement]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Fact].[Movement](
	[Movement Key] [bigint] IDENTITY(1,1) NOT NULL,
	[Date Key] [date] NOT NULL,
	[Stock Item Key] [int] NOT NULL,
	[Customer Key] [int] NULL,
	[Supplier Key] [int] NULL,
	[Transaction Type Key] [int] NOT NULL,
	[WWI Stock Item Transaction ID] [int] NOT NULL,
	[WWI Invoice ID] [int] NULL,
	[WWI Purchase Order ID] [int] NULL,
	[Quantity] [int] NOT NULL,
	[Lineage Key] [int] NOT NULL,
 CONSTRAINT [PK_Fact_Movement] PRIMARY KEY NONCLUSTERED 
(
	[Movement Key] ASC,
	[Date Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Date Key])
) ON [PS_Date]([Date Key])
GO
/****** Object:  Table [Fact].[Order]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Fact].[Order](
	[Order Key] [bigint] IDENTITY(1,1) NOT NULL,
	[City Key] [int] NOT NULL,
	[Customer Key] [int] NOT NULL,
	[Stock Item Key] [int] NOT NULL,
	[Order Date Key] [date] NOT NULL,
	[Picked Date Key] [date] NULL,
	[Salesperson Key] [int] NOT NULL,
	[Picker Key] [int] NULL,
	[WWI Order ID] [int] NOT NULL,
	[WWI Backorder ID] [int] NULL,
	[Description] [nvarchar](100) NOT NULL,
	[Package] [nvarchar](50) NOT NULL,
	[Quantity] [int] NOT NULL,
	[Unit Price] [decimal](18, 2) NOT NULL,
	[Tax Rate] [decimal](18, 3) NOT NULL,
	[Total Excluding Tax] [decimal](18, 2) NOT NULL,
	[Tax Amount] [decimal](18, 2) NOT NULL,
	[Total Including Tax] [decimal](18, 2) NOT NULL,
	[Lineage Key] [int] NOT NULL,
 CONSTRAINT [PK_Fact_Order] PRIMARY KEY NONCLUSTERED 
(
	[Order Key] ASC,
	[Order Date Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Order Date Key])
) ON [PS_Date]([Order Date Key])
GO
/****** Object:  Table [Fact].[Purchase]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Fact].[Purchase](
	[Purchase Key] [bigint] IDENTITY(1,1) NOT NULL,
	[Date Key] [date] NOT NULL,
	[Supplier Key] [int] NOT NULL,
	[Stock Item Key] [int] NOT NULL,
	[WWI Purchase Order ID] [int] NULL,
	[Ordered Outers] [int] NOT NULL,
	[Ordered Quantity] [int] NOT NULL,
	[Received Outers] [int] NOT NULL,
	[Package] [nvarchar](50) NOT NULL,
	[Is Order Finalized] [bit] NOT NULL,
	[Lineage Key] [int] NOT NULL,
 CONSTRAINT [PK_Fact_Purchase] PRIMARY KEY NONCLUSTERED 
(
	[Purchase Key] ASC,
	[Date Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Date Key])
) ON [PS_Date]([Date Key])
GO
/****** Object:  Table [Fact].[Sale]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Fact].[Sale](
	[Sale Key] [bigint] IDENTITY(1,1) NOT NULL,
	[City Key] [int] NOT NULL,
	[Customer Key] [int] NOT NULL,
	[Bill To Customer Key] [int] NOT NULL,
	[Stock Item Key] [int] NOT NULL,
	[Invoice Date Key] [date] NOT NULL,
	[Delivery Date Key] [date] NULL,
	[Salesperson Key] [int] NOT NULL,
	[WWI Invoice ID] [int] NOT NULL,
	[Description] [nvarchar](100) NOT NULL,
	[Package] [nvarchar](50) NOT NULL,
	[Quantity] [int] NOT NULL,
	[Unit Price] [decimal](18, 2) NOT NULL,
	[Tax Rate] [decimal](18, 3) NOT NULL,
	[Total Excluding Tax] [decimal](18, 2) NOT NULL,
	[Tax Amount] [decimal](18, 2) NOT NULL,
	[Profit] [decimal](18, 2) NOT NULL,
	[Total Including Tax] [decimal](18, 2) NOT NULL,
	[Total Dry Items] [int] NOT NULL,
	[Total Chiller Items] [int] NOT NULL,
	[Lineage Key] [int] NOT NULL,
 CONSTRAINT [PK_Fact_Sale] PRIMARY KEY NONCLUSTERED 
(
	[Sale Key] ASC,
	[Invoice Date Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Invoice Date Key])
) ON [PS_Date]([Invoice Date Key])
GO
/****** Object:  Table [Fact].[Stock Holding]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Fact].[Stock Holding](
	[Stock Holding Key] [bigint] IDENTITY(1,1) NOT NULL,
	[Stock Item Key] [int] NOT NULL,
	[Quantity On Hand] [int] NOT NULL,
	[Bin Location] [nvarchar](20) NOT NULL,
	[Last Stocktake Quantity] [int] NOT NULL,
	[Last Cost Price] [decimal](18, 2) NOT NULL,
	[Reorder Level] [int] NOT NULL,
	[Target Stock Level] [int] NOT NULL,
	[Lineage Key] [int] NOT NULL,
 CONSTRAINT [PK_Fact_Stock_Holding] PRIMARY KEY NONCLUSTERED 
(
	[Stock Holding Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [USERDATA]
) ON [USERDATA]
GO
/****** Object:  Table [Fact].[Transaction]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Fact].[Transaction](
	[Transaction Key] [bigint] IDENTITY(1,1) NOT NULL,
	[Date Key] [date] NOT NULL,
	[Customer Key] [int] NULL,
	[Bill To Customer Key] [int] NULL,
	[Supplier Key] [int] NULL,
	[Transaction Type Key] [int] NOT NULL,
	[Payment Method Key] [int] NULL,
	[WWI Customer Transaction ID] [int] NULL,
	[WWI Supplier Transaction ID] [int] NULL,
	[WWI Invoice ID] [int] NULL,
	[WWI Purchase Order ID] [int] NULL,
	[Supplier Invoice Number] [nvarchar](20) NULL,
	[Total Excluding Tax] [decimal](18, 2) NOT NULL,
	[Tax Amount] [decimal](18, 2) NOT NULL,
	[Total Including Tax] [decimal](18, 2) NOT NULL,
	[Outstanding Balance] [decimal](18, 2) NOT NULL,
	[Is Finalized] [bit] NOT NULL,
	[Lineage Key] [int] NOT NULL,
 CONSTRAINT [PK_Fact_Transaction] PRIMARY KEY NONCLUSTERED 
(
	[Transaction Key] ASC,
	[Date Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Date Key])
) ON [PS_Date]([Date Key])
GO
/****** Object:  Table [Integration].[City_Staging]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Integration].[City_Staging](
	[City Staging Key] [int] IDENTITY(1,1) NOT NULL,
	[WWI City ID] [int] NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[State Province] [nvarchar](50) NOT NULL,
	[Country] [nvarchar](60) NOT NULL,
	[Continent] [nvarchar](30) NOT NULL,
	[Sales Territory] [nvarchar](50) NOT NULL,
	[Region] [nvarchar](30) NOT NULL,
	[Subregion] [nvarchar](30) NOT NULL,
	[Location] [geography] NULL,
	[Latest Recorded Population] [bigint] NOT NULL,
	[Valid From] [datetime2](7) NOT NULL,
	[Valid To] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Integration_City_Staging] PRIMARY KEY CLUSTERED 
(
	[City Staging Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [USERDATA]
) ON [USERDATA] TEXTIMAGE_ON [USERDATA]
GO
/****** Object:  Table [Integration].[Customer_Staging]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Integration].[Customer_Staging]
(
	[Customer Staging Key] [int] IDENTITY(1,1) NOT NULL,
	[WWI Customer ID] [int] NOT NULL,
	[Customer] [nvarchar](100) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[Bill To Customer] [nvarchar](100) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[Category] [nvarchar](50) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[Buying Group] [nvarchar](50) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[Primary Contact] [nvarchar](50) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[Postal Code] [nvarchar](10) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[Valid From] [datetime2](7) NOT NULL,
	[Valid To] [datetime2](7) NOT NULL,

 CONSTRAINT [PK_Integration_Customer_Staging]  PRIMARY KEY NONCLUSTERED 
(
	[Customer Staging Key] ASC
)
)WITH ( MEMORY_OPTIMIZED = ON , DURABILITY = SCHEMA_ONLY )
GO
/****** Object:  Table [Integration].[Employee_Staging]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Integration].[Employee_Staging]
(
	[Employee Staging Key] [int] IDENTITY(1,1) NOT NULL,
	[WWI Employee ID] [int] NOT NULL,
	[Employee] [nvarchar](50) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[Preferred Name] [nvarchar](50) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[Is Salesperson] [bit] NOT NULL,
	[Photo] [varbinary](max) NULL,
	[Valid From] [datetime2](7) NOT NULL,
	[Valid To] [datetime2](7) NOT NULL,

 CONSTRAINT [PK_Integration_Employee_Staging]  PRIMARY KEY NONCLUSTERED 
(
	[Employee Staging Key] ASC
)
)WITH ( MEMORY_OPTIMIZED = ON , DURABILITY = SCHEMA_ONLY )
GO
/****** Object:  Table [Integration].[ETL Cutoff]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Integration].[ETL Cutoff](
	[Table Name] [sysname] NOT NULL,
	[Cutoff Time] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Integration_ETL_Cutoff] PRIMARY KEY CLUSTERED 
(
	[Table Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [USERDATA]
) ON [USERDATA]
GO
/****** Object:  Table [Integration].[Lineage]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Integration].[Lineage](
	[Lineage Key] [int] NOT NULL,
	[Data Load Started] [datetime2](7) NOT NULL,
	[Table Name] [sysname] NOT NULL,
	[Data Load Completed] [datetime2](7) NULL,
	[Was Successful] [bit] NOT NULL,
	[Source System Cutoff Time] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Integration_Lineage] PRIMARY KEY CLUSTERED 
(
	[Lineage Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [USERDATA]
) ON [USERDATA]
GO
/****** Object:  Table [Integration].[Movement_Staging]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Integration].[Movement_Staging]
(
	[Movement Staging Key] [bigint] IDENTITY(1,1) NOT NULL,
	[Date Key] [date] NULL,
	[Stock Item Key] [int] NULL,
	[Customer Key] [int] NULL,
	[Supplier Key] [int] NULL,
	[Transaction Type Key] [int] NULL,
	[WWI Stock Item Transaction ID] [int] NULL,
	[WWI Invoice ID] [int] NULL,
	[WWI Purchase Order ID] [int] NULL,
	[Quantity] [int] NULL,
	[WWI Stock Item ID] [int] NULL,
	[WWI Customer ID] [int] NULL,
	[WWI Supplier ID] [int] NULL,
	[WWI Transaction Type ID] [int] NULL,
	[Last Modifed When] [datetime2](7) NULL,

 CONSTRAINT [PK_Integration_Movement_Staging]  PRIMARY KEY NONCLUSTERED 
(
	[Movement Staging Key] ASC
)
)WITH ( MEMORY_OPTIMIZED = ON , DURABILITY = SCHEMA_ONLY )
GO
/****** Object:  Table [Integration].[Order_Staging]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Integration].[Order_Staging]
(
	[Order Staging Key] [bigint] IDENTITY(1,1) NOT NULL,
	[City Key] [int] NULL,
	[Customer Key] [int] NULL,
	[Stock Item Key] [int] NULL,
	[Order Date Key] [date] NULL,
	[Picked Date Key] [date] NULL,
	[Salesperson Key] [int] NULL,
	[Picker Key] [int] NULL,
	[WWI Order ID] [int] NULL,
	[WWI Backorder ID] [int] NULL,
	[Description] [nvarchar](100) COLLATE Latin1_General_100_CI_AS NULL,
	[Package] [nvarchar](50) COLLATE Latin1_General_100_CI_AS NULL,
	[Quantity] [int] NULL,
	[Unit Price] [decimal](18, 2) NULL,
	[Tax Rate] [decimal](18, 3) NULL,
	[Total Excluding Tax] [decimal](18, 2) NULL,
	[Tax Amount] [decimal](18, 2) NULL,
	[Total Including Tax] [decimal](18, 2) NULL,
	[Lineage Key] [int] NULL,
	[WWI City ID] [int] NULL,
	[WWI Customer ID] [int] NULL,
	[WWI Stock Item ID] [int] NULL,
	[WWI Salesperson ID] [int] NULL,
	[WWI Picker ID] [int] NULL,
	[Last Modified When] [datetime2](7) NULL,

 CONSTRAINT [PK_Integration_Order_Staging]  PRIMARY KEY NONCLUSTERED 
(
	[Order Staging Key] ASC
)
)WITH ( MEMORY_OPTIMIZED = ON , DURABILITY = SCHEMA_ONLY )
GO
/****** Object:  Table [Integration].[PaymentMethod_Staging]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Integration].[PaymentMethod_Staging]
(
	[Payment Method Staging Key] [int] IDENTITY(1,1) NOT NULL,
	[WWI Payment Method ID] [int] NOT NULL,
	[Payment Method] [nvarchar](50) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[Valid From] [datetime2](7) NOT NULL,
	[Valid To] [datetime2](7) NOT NULL,

 CONSTRAINT [PK_Integration_Payment_Method_Staging]  PRIMARY KEY NONCLUSTERED 
(
	[Payment Method Staging Key] ASC
)
)WITH ( MEMORY_OPTIMIZED = ON , DURABILITY = SCHEMA_ONLY )
GO
/****** Object:  Table [Integration].[Purchase_Staging]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Integration].[Purchase_Staging]
(
	[Purchase Staging Key] [bigint] IDENTITY(1,1) NOT NULL,
	[Date Key] [date] NULL,
	[Supplier Key] [int] NULL,
	[Stock Item Key] [int] NULL,
	[WWI Purchase Order ID] [int] NULL,
	[Ordered Outers] [int] NULL,
	[Ordered Quantity] [int] NULL,
	[Received Outers] [int] NULL,
	[Package] [nvarchar](50) COLLATE Latin1_General_100_CI_AS NULL,
	[Is Order Finalized] [bit] NULL,
	[WWI Supplier ID] [int] NULL,
	[WWI Stock Item ID] [int] NULL,
	[Last Modified When] [datetime2](7) NULL,

 CONSTRAINT [PK_Integration_Purchase_Staging]  PRIMARY KEY NONCLUSTERED 
(
	[Purchase Staging Key] ASC
)
)WITH ( MEMORY_OPTIMIZED = ON , DURABILITY = SCHEMA_ONLY )
GO
/****** Object:  Table [Integration].[Sale_Staging]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Integration].[Sale_Staging]
(
	[Sale Staging Key] [bigint] IDENTITY(1,1) NOT NULL,
	[City Key] [int] NULL,
	[Customer Key] [int] NULL,
	[Bill To Customer Key] [int] NULL,
	[Stock Item Key] [int] NULL,
	[Invoice Date Key] [date] NULL,
	[Delivery Date Key] [date] NULL,
	[Salesperson Key] [int] NULL,
	[WWI Invoice ID] [int] NULL,
	[Description] [nvarchar](100) COLLATE Latin1_General_100_CI_AS NULL,
	[Package] [nvarchar](50) COLLATE Latin1_General_100_CI_AS NULL,
	[Quantity] [int] NULL,
	[Unit Price] [decimal](18, 2) NULL,
	[Tax Rate] [decimal](18, 3) NULL,
	[Total Excluding Tax] [decimal](18, 2) NULL,
	[Tax Amount] [decimal](18, 2) NULL,
	[Profit] [decimal](18, 2) NULL,
	[Total Including Tax] [decimal](18, 2) NULL,
	[Total Dry Items] [int] NULL,
	[Total Chiller Items] [int] NULL,
	[WWI City ID] [int] NULL,
	[WWI Customer ID] [int] NULL,
	[WWI Bill To Customer ID] [int] NULL,
	[WWI Stock Item ID] [int] NULL,
	[WWI Salesperson ID] [int] NULL,
	[Last Modified When] [datetime2](7) NULL,

 CONSTRAINT [PK_Integration_Sale_Staging]  PRIMARY KEY NONCLUSTERED 
(
	[Sale Staging Key] ASC
)
)WITH ( MEMORY_OPTIMIZED = ON , DURABILITY = SCHEMA_ONLY )
GO
/****** Object:  Table [Integration].[StockHolding_Staging]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Integration].[StockHolding_Staging]
(
	[Stock Holding Staging Key] [bigint] IDENTITY(1,1) NOT NULL,
	[Stock Item Key] [int] NULL,
	[Quantity On Hand] [int] NULL,
	[Bin Location] [nvarchar](20) COLLATE Latin1_General_100_CI_AS NULL,
	[Last Stocktake Quantity] [int] NULL,
	[Last Cost Price] [decimal](18, 2) NULL,
	[Reorder Level] [int] NULL,
	[Target Stock Level] [int] NULL,
	[WWI Stock Item ID] [int] NULL,

 CONSTRAINT [PK_Integration_Stock_Holding_Staging]  PRIMARY KEY NONCLUSTERED 
(
	[Stock Holding Staging Key] ASC
)
)WITH ( MEMORY_OPTIMIZED = ON , DURABILITY = SCHEMA_ONLY )
GO
/****** Object:  Table [Integration].[StockItem_Staging]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Integration].[StockItem_Staging]
(
	[Stock Item Staging Key] [int] IDENTITY(1,1) NOT NULL,
	[WWI Stock Item ID] [int] NOT NULL,
	[Stock Item] [nvarchar](100) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[Color] [nvarchar](20) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[Selling Package] [nvarchar](50) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[Buying Package] [nvarchar](50) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[Brand] [nvarchar](50) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[Size] [nvarchar](20) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[Lead Time Days] [int] NOT NULL,
	[Quantity Per Outer] [int] NOT NULL,
	[Is Chiller Stock] [bit] NOT NULL,
	[Barcode] [nvarchar](50) COLLATE Latin1_General_100_CI_AS NULL,
	[Tax Rate] [decimal](18, 3) NOT NULL,
	[Unit Price] [decimal](18, 2) NOT NULL,
	[Recommended Retail Price] [decimal](18, 2) NULL,
	[Typical Weight Per Unit] [decimal](18, 3) NOT NULL,
	[Photo] [varbinary](max) NULL,
	[Valid From] [datetime2](7) NOT NULL,
	[Valid To] [datetime2](7) NOT NULL,

 CONSTRAINT [PK_Integration_Stock_Item_Staging]  PRIMARY KEY NONCLUSTERED 
(
	[Stock Item Staging Key] ASC
)
)WITH ( MEMORY_OPTIMIZED = ON , DURABILITY = SCHEMA_ONLY )
GO
/****** Object:  Table [Integration].[Supplier_Staging]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Integration].[Supplier_Staging]
(
	[Supplier Staging Key] [int] IDENTITY(1,1) NOT NULL,
	[WWI Supplier ID] [int] NOT NULL,
	[Supplier] [nvarchar](100) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[Category] [nvarchar](50) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[Primary Contact] [nvarchar](50) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[Supplier Reference] [nvarchar](20) COLLATE Latin1_General_100_CI_AS NULL,
	[Payment Days] [int] NOT NULL,
	[Postal Code] [nvarchar](10) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[Valid From] [datetime2](7) NOT NULL,
	[Valid To] [datetime2](7) NOT NULL,

 CONSTRAINT [PK_Integration_Supplier_Staging]  PRIMARY KEY NONCLUSTERED 
(
	[Supplier Staging Key] ASC
)
)WITH ( MEMORY_OPTIMIZED = ON , DURABILITY = SCHEMA_ONLY )
GO
/****** Object:  Table [Integration].[Transaction_Staging]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Integration].[Transaction_Staging]
(
	[Transaction Staging Key] [bigint] IDENTITY(1,1) NOT NULL,
	[Date Key] [date] NULL,
	[Customer Key] [int] NULL,
	[Bill To Customer Key] [int] NULL,
	[Supplier Key] [int] NULL,
	[Transaction Type Key] [int] NULL,
	[Payment Method Key] [int] NULL,
	[WWI Customer Transaction ID] [int] NULL,
	[WWI Supplier Transaction ID] [int] NULL,
	[WWI Invoice ID] [int] NULL,
	[WWI Purchase Order ID] [int] NULL,
	[Supplier Invoice Number] [nvarchar](20) COLLATE Latin1_General_100_CI_AS NULL,
	[Total Excluding Tax] [decimal](18, 2) NULL,
	[Tax Amount] [decimal](18, 2) NULL,
	[Total Including Tax] [decimal](18, 2) NULL,
	[Outstanding Balance] [decimal](18, 2) NULL,
	[Is Finalized] [bit] NULL,
	[WWI Customer ID] [int] NULL,
	[WWI Bill To Customer ID] [int] NULL,
	[WWI Supplier ID] [int] NULL,
	[WWI Transaction Type ID] [int] NULL,
	[WWI Payment Method ID] [int] NULL,
	[Last Modified When] [datetime2](7) NULL,

 CONSTRAINT [PK_Integration_Transaction_Staging]  PRIMARY KEY NONCLUSTERED 
(
	[Transaction Staging Key] ASC
)
)WITH ( MEMORY_OPTIMIZED = ON , DURABILITY = SCHEMA_ONLY )
GO
/****** Object:  Table [Integration].[TransactionType_Staging]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Integration].[TransactionType_Staging]
(
	[Transaction Type Staging Key] [int] IDENTITY(1,1) NOT NULL,
	[WWI Transaction Type ID] [int] NOT NULL,
	[Transaction Type] [nvarchar](50) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[Valid From] [datetime2](7) NOT NULL,
	[Valid To] [datetime2](7) NOT NULL,

 CONSTRAINT [PK_Integration_Transaction_Type_Staging]  PRIMARY KEY NONCLUSTERED 
(
	[Transaction Type Staging Key] ASC
)
)WITH ( MEMORY_OPTIMIZED = ON , DURABILITY = SCHEMA_ONLY )
GO
/****** Object:  Index [IX_Dimension_City_WWICityID]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [IX_Dimension_City_WWICityID] ON [Dimension].[City]
(
	[WWI City ID] ASC,
	[Valid From] ASC,
	[Valid To] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [USERDATA]
GO
/****** Object:  Index [IX_Dimension_Customer_WWICustomerID]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [IX_Dimension_Customer_WWICustomerID] ON [Dimension].[Customer]
(
	[WWI Customer ID] ASC,
	[Valid From] ASC,
	[Valid To] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [USERDATA]
GO
/****** Object:  Index [IX_Dimension_Employee_WWIEmployeeID]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [IX_Dimension_Employee_WWIEmployeeID] ON [Dimension].[Employee]
(
	[WWI Employee ID] ASC,
	[Valid From] ASC,
	[Valid To] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [USERDATA]
GO
/****** Object:  Index [IX_Dimension_Payment_Method_WWIPaymentMethodID]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [IX_Dimension_Payment_Method_WWIPaymentMethodID] ON [Dimension].[Payment Method]
(
	[WWI Payment Method ID] ASC,
	[Valid From] ASC,
	[Valid To] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [USERDATA]
GO
/****** Object:  Index [IX_Dimension_Stock_Item_WWIStockItemID]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [IX_Dimension_Stock_Item_WWIStockItemID] ON [Dimension].[Stock Item]
(
	[WWI Stock Item ID] ASC,
	[Valid From] ASC,
	[Valid To] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [USERDATA]
GO
/****** Object:  Index [IX_Dimension_Supplier_WWISupplierID]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [IX_Dimension_Supplier_WWISupplierID] ON [Dimension].[Supplier]
(
	[WWI Supplier ID] ASC,
	[Valid From] ASC,
	[Valid To] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [USERDATA]
GO
/****** Object:  Index [IX_Dimension_Transaction_Type_WWITransactionTypeID]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [IX_Dimension_Transaction_Type_WWITransactionTypeID] ON [Dimension].[Transaction Type]
(
	[WWI Transaction Type ID] ASC,
	[Valid From] ASC,
	[Valid To] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [USERDATA]
GO
/****** Object:  Index [FK_Fact_Movement_Customer_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Movement_Customer_Key] ON [Fact].[Movement]
(
	[Customer Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Date Key])
GO
/****** Object:  Index [FK_Fact_Movement_Date_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Movement_Date_Key] ON [Fact].[Movement]
(
	[Date Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Date Key])
GO
/****** Object:  Index [FK_Fact_Movement_Stock_Item_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Movement_Stock_Item_Key] ON [Fact].[Movement]
(
	[Stock Item Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Date Key])
GO
/****** Object:  Index [FK_Fact_Movement_Supplier_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Movement_Supplier_Key] ON [Fact].[Movement]
(
	[Supplier Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Date Key])
GO
/****** Object:  Index [FK_Fact_Movement_Transaction_Type_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Movement_Transaction_Type_Key] ON [Fact].[Movement]
(
	[Transaction Type Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Date Key])
GO
/****** Object:  Index [IX_Integration_Movement_WWI_Stock_Item_Transaction_ID]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [IX_Integration_Movement_WWI_Stock_Item_Transaction_ID] ON [Fact].[Movement]
(
	[WWI Stock Item Transaction ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Date Key])
GO
/****** Object:  Index [FK_Fact_Order_City_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Order_City_Key] ON [Fact].[Order]
(
	[City Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Order Date Key])
GO
/****** Object:  Index [FK_Fact_Order_Customer_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Order_Customer_Key] ON [Fact].[Order]
(
	[Customer Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Order Date Key])
GO
/****** Object:  Index [FK_Fact_Order_Order_Date_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Order_Order_Date_Key] ON [Fact].[Order]
(
	[Order Date Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Order Date Key])
GO
/****** Object:  Index [FK_Fact_Order_Picked_Date_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Order_Picked_Date_Key] ON [Fact].[Order]
(
	[Picked Date Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Order Date Key])
GO
/****** Object:  Index [FK_Fact_Order_Picker_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Order_Picker_Key] ON [Fact].[Order]
(
	[Picker Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Order Date Key])
GO
/****** Object:  Index [FK_Fact_Order_Salesperson_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Order_Salesperson_Key] ON [Fact].[Order]
(
	[Salesperson Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Order Date Key])
GO
/****** Object:  Index [FK_Fact_Order_Stock_Item_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Order_Stock_Item_Key] ON [Fact].[Order]
(
	[Stock Item Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Order Date Key])
GO
/****** Object:  Index [IX_Integration_Order_WWI_Order_ID]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [IX_Integration_Order_WWI_Order_ID] ON [Fact].[Order]
(
	[WWI Order ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Order Date Key])
GO
/****** Object:  Index [FK_Fact_Purchase_Date_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Purchase_Date_Key] ON [Fact].[Purchase]
(
	[Date Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Date Key])
GO
/****** Object:  Index [FK_Fact_Purchase_Stock_Item_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Purchase_Stock_Item_Key] ON [Fact].[Purchase]
(
	[Stock Item Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Date Key])
GO
/****** Object:  Index [FK_Fact_Purchase_Supplier_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Purchase_Supplier_Key] ON [Fact].[Purchase]
(
	[Supplier Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Date Key])
GO
/****** Object:  Index [FK_Fact_Sale_Bill_To_Customer_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Sale_Bill_To_Customer_Key] ON [Fact].[Sale]
(
	[Bill To Customer Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Invoice Date Key])
GO
/****** Object:  Index [FK_Fact_Sale_City_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Sale_City_Key] ON [Fact].[Sale]
(
	[City Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Invoice Date Key])
GO
/****** Object:  Index [FK_Fact_Sale_Customer_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Sale_Customer_Key] ON [Fact].[Sale]
(
	[Customer Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Invoice Date Key])
GO
/****** Object:  Index [FK_Fact_Sale_Delivery_Date_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Sale_Delivery_Date_Key] ON [Fact].[Sale]
(
	[Delivery Date Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Invoice Date Key])
GO
/****** Object:  Index [FK_Fact_Sale_Invoice_Date_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Sale_Invoice_Date_Key] ON [Fact].[Sale]
(
	[Invoice Date Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Invoice Date Key])
GO
/****** Object:  Index [FK_Fact_Sale_Salesperson_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Sale_Salesperson_Key] ON [Fact].[Sale]
(
	[Salesperson Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Invoice Date Key])
GO
/****** Object:  Index [FK_Fact_Sale_Stock_Item_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Sale_Stock_Item_Key] ON [Fact].[Sale]
(
	[Stock Item Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Invoice Date Key])
GO
/****** Object:  Index [FK_Fact_Stock_Holding_Stock_Item_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Stock_Holding_Stock_Item_Key] ON [Fact].[Stock Holding]
(
	[Stock Item Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [USERDATA]
GO
/****** Object:  Index [FK_Fact_Transaction_Bill_To_Customer_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Transaction_Bill_To_Customer_Key] ON [Fact].[Transaction]
(
	[Bill To Customer Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Date Key])
GO
/****** Object:  Index [FK_Fact_Transaction_Customer_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Transaction_Customer_Key] ON [Fact].[Transaction]
(
	[Customer Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Date Key])
GO
/****** Object:  Index [FK_Fact_Transaction_Date_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Transaction_Date_Key] ON [Fact].[Transaction]
(
	[Date Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Date Key])
GO
/****** Object:  Index [FK_Fact_Transaction_Payment_Method_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Transaction_Payment_Method_Key] ON [Fact].[Transaction]
(
	[Payment Method Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Date Key])
GO
/****** Object:  Index [FK_Fact_Transaction_Supplier_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Transaction_Supplier_Key] ON [Fact].[Transaction]
(
	[Supplier Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Date Key])
GO
/****** Object:  Index [FK_Fact_Transaction_Transaction_Type_Key]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [FK_Fact_Transaction_Transaction_Type_Key] ON [Fact].[Transaction]
(
	[Transaction Type Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PS_Date]([Date Key])
GO
/****** Object:  Index [IX_Integration_City_Staging_WWI_City_ID]    Script Date: 2024/05/01 18:49:23 ******/
CREATE NONCLUSTERED INDEX [IX_Integration_City_Staging_WWI_City_ID] ON [Integration].[City_Staging]
(
	[WWI City ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [USERDATA]
GO
/****** Object:  Index [CCX_Fact_Movement]    Script Date: 2024/05/01 18:49:23 ******/
CREATE CLUSTERED COLUMNSTORE INDEX [CCX_Fact_Movement] ON [Fact].[Movement] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0, DATA_COMPRESSION = COLUMNSTORE) ON [PS_Date]([Date Key])
GO
/****** Object:  Index [CCX_Fact_Order]    Script Date: 2024/05/01 18:49:23 ******/
CREATE CLUSTERED COLUMNSTORE INDEX [CCX_Fact_Order] ON [Fact].[Order] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0, DATA_COMPRESSION = COLUMNSTORE) ON [PS_Date]([Order Date Key])
GO
/****** Object:  Index [CCX_Fact_Purchase]    Script Date: 2024/05/01 18:49:23 ******/
CREATE CLUSTERED COLUMNSTORE INDEX [CCX_Fact_Purchase] ON [Fact].[Purchase] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0, DATA_COMPRESSION = COLUMNSTORE) ON [PS_Date]([Date Key])
GO
/****** Object:  Index [CCX_Fact_Sale]    Script Date: 2024/05/01 18:49:23 ******/
CREATE CLUSTERED COLUMNSTORE INDEX [CCX_Fact_Sale] ON [Fact].[Sale] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0, DATA_COMPRESSION = COLUMNSTORE) ON [PS_Date]([Invoice Date Key])
GO
/****** Object:  Index [CCX_Fact_Stock_Holding]    Script Date: 2024/05/01 18:49:23 ******/
CREATE CLUSTERED COLUMNSTORE INDEX [CCX_Fact_Stock_Holding] ON [Fact].[Stock Holding] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0, DATA_COMPRESSION = COLUMNSTORE) ON [USERDATA]
GO
/****** Object:  Index [CCX_Fact_Transaction]    Script Date: 2024/05/01 18:49:23 ******/
CREATE CLUSTERED COLUMNSTORE INDEX [CCX_Fact_Transaction] ON [Fact].[Transaction] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0, DATA_COMPRESSION = COLUMNSTORE) ON [PS_Date]([Date Key])
GO
ALTER TABLE [Dimension].[City] ADD  CONSTRAINT [DF_Dimension_City_City_Key]  DEFAULT (NEXT VALUE FOR [Sequences].[CityKey]) FOR [City Key]
GO
ALTER TABLE [Dimension].[Customer] ADD  CONSTRAINT [DF_Dimension_Customer_Customer_Key]  DEFAULT (NEXT VALUE FOR [Sequences].[CustomerKey]) FOR [Customer Key]
GO
ALTER TABLE [Dimension].[Employee] ADD  CONSTRAINT [DF_Dimension_Employee_Employee_Key]  DEFAULT (NEXT VALUE FOR [Sequences].[EmployeeKey]) FOR [Employee Key]
GO
ALTER TABLE [Dimension].[Payment Method] ADD  CONSTRAINT [DF_Dimension_Payment_Method_Payment_Method_Key]  DEFAULT (NEXT VALUE FOR [Sequences].[PaymentMethodKey]) FOR [Payment Method Key]
GO
ALTER TABLE [Dimension].[Stock Item] ADD  CONSTRAINT [DF_Dimension_Stock_Item_Stock_Item_Key]  DEFAULT (NEXT VALUE FOR [Sequences].[StockItemKey]) FOR [Stock Item Key]
GO
ALTER TABLE [Dimension].[Supplier] ADD  CONSTRAINT [DF_Dimension_Supplier_Supplier_Key]  DEFAULT (NEXT VALUE FOR [Sequences].[SupplierKey]) FOR [Supplier Key]
GO
ALTER TABLE [Dimension].[Transaction Type] ADD  CONSTRAINT [DF_Dimension_Transaction_Type_Transaction_Type_Key]  DEFAULT (NEXT VALUE FOR [Sequences].[TransactionTypeKey]) FOR [Transaction Type Key]
GO
ALTER TABLE [Integration].[Lineage] ADD  CONSTRAINT [DF_Integration_Lineage_Lineage_Key]  DEFAULT (NEXT VALUE FOR [Sequences].[LineageKey]) FOR [Lineage Key]
GO
ALTER TABLE [Fact].[Movement]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Movement_Customer_Key_Dimension_Customer] FOREIGN KEY([Customer Key])
REFERENCES [Dimension].[Customer] ([Customer Key])
GO
ALTER TABLE [Fact].[Movement] CHECK CONSTRAINT [FK_Fact_Movement_Customer_Key_Dimension_Customer]
GO
ALTER TABLE [Fact].[Movement]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Movement_Date_Key_Dimension_Date] FOREIGN KEY([Date Key])
REFERENCES [Dimension].[Date] ([Date])
GO
ALTER TABLE [Fact].[Movement] CHECK CONSTRAINT [FK_Fact_Movement_Date_Key_Dimension_Date]
GO
ALTER TABLE [Fact].[Movement]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Movement_Stock_Item_Key_Dimension_Stock Item] FOREIGN KEY([Stock Item Key])
REFERENCES [Dimension].[Stock Item] ([Stock Item Key])
GO
ALTER TABLE [Fact].[Movement] CHECK CONSTRAINT [FK_Fact_Movement_Stock_Item_Key_Dimension_Stock Item]
GO
ALTER TABLE [Fact].[Movement]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Movement_Supplier_Key_Dimension_Supplier] FOREIGN KEY([Supplier Key])
REFERENCES [Dimension].[Supplier] ([Supplier Key])
GO
ALTER TABLE [Fact].[Movement] CHECK CONSTRAINT [FK_Fact_Movement_Supplier_Key_Dimension_Supplier]
GO
ALTER TABLE [Fact].[Movement]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Movement_Transaction_Type_Key_Dimension_Transaction Type] FOREIGN KEY([Transaction Type Key])
REFERENCES [Dimension].[Transaction Type] ([Transaction Type Key])
GO
ALTER TABLE [Fact].[Movement] CHECK CONSTRAINT [FK_Fact_Movement_Transaction_Type_Key_Dimension_Transaction Type]
GO
ALTER TABLE [Fact].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Order_City_Key_Dimension_City] FOREIGN KEY([City Key])
REFERENCES [Dimension].[City] ([City Key])
GO
ALTER TABLE [Fact].[Order] CHECK CONSTRAINT [FK_Fact_Order_City_Key_Dimension_City]
GO
ALTER TABLE [Fact].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Order_Customer_Key_Dimension_Customer] FOREIGN KEY([Customer Key])
REFERENCES [Dimension].[Customer] ([Customer Key])
GO
ALTER TABLE [Fact].[Order] CHECK CONSTRAINT [FK_Fact_Order_Customer_Key_Dimension_Customer]
GO
ALTER TABLE [Fact].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Order_Order_Date_Key_Dimension_Date] FOREIGN KEY([Order Date Key])
REFERENCES [Dimension].[Date] ([Date])
GO
ALTER TABLE [Fact].[Order] CHECK CONSTRAINT [FK_Fact_Order_Order_Date_Key_Dimension_Date]
GO
ALTER TABLE [Fact].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Order_Picked_Date_Key_Dimension_Date] FOREIGN KEY([Picked Date Key])
REFERENCES [Dimension].[Date] ([Date])
GO
ALTER TABLE [Fact].[Order] CHECK CONSTRAINT [FK_Fact_Order_Picked_Date_Key_Dimension_Date]
GO
ALTER TABLE [Fact].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Order_Picker_Key_Dimension_Employee] FOREIGN KEY([Picker Key])
REFERENCES [Dimension].[Employee] ([Employee Key])
GO
ALTER TABLE [Fact].[Order] CHECK CONSTRAINT [FK_Fact_Order_Picker_Key_Dimension_Employee]
GO
ALTER TABLE [Fact].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Order_Salesperson_Key_Dimension_Employee] FOREIGN KEY([Salesperson Key])
REFERENCES [Dimension].[Employee] ([Employee Key])
GO
ALTER TABLE [Fact].[Order] CHECK CONSTRAINT [FK_Fact_Order_Salesperson_Key_Dimension_Employee]
GO
ALTER TABLE [Fact].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Order_Stock_Item_Key_Dimension_Stock Item] FOREIGN KEY([Stock Item Key])
REFERENCES [Dimension].[Stock Item] ([Stock Item Key])
GO
ALTER TABLE [Fact].[Order] CHECK CONSTRAINT [FK_Fact_Order_Stock_Item_Key_Dimension_Stock Item]
GO
ALTER TABLE [Fact].[Purchase]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Purchase_Date_Key_Dimension_Date] FOREIGN KEY([Date Key])
REFERENCES [Dimension].[Date] ([Date])
GO
ALTER TABLE [Fact].[Purchase] CHECK CONSTRAINT [FK_Fact_Purchase_Date_Key_Dimension_Date]
GO
ALTER TABLE [Fact].[Purchase]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Purchase_Stock_Item_Key_Dimension_Stock Item] FOREIGN KEY([Stock Item Key])
REFERENCES [Dimension].[Stock Item] ([Stock Item Key])
GO
ALTER TABLE [Fact].[Purchase] CHECK CONSTRAINT [FK_Fact_Purchase_Stock_Item_Key_Dimension_Stock Item]
GO
ALTER TABLE [Fact].[Purchase]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Purchase_Supplier_Key_Dimension_Supplier] FOREIGN KEY([Supplier Key])
REFERENCES [Dimension].[Supplier] ([Supplier Key])
GO
ALTER TABLE [Fact].[Purchase] CHECK CONSTRAINT [FK_Fact_Purchase_Supplier_Key_Dimension_Supplier]
GO
ALTER TABLE [Fact].[Sale]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Sale_Bill_To_Customer_Key_Dimension_Customer] FOREIGN KEY([Bill To Customer Key])
REFERENCES [Dimension].[Customer] ([Customer Key])
GO
ALTER TABLE [Fact].[Sale] CHECK CONSTRAINT [FK_Fact_Sale_Bill_To_Customer_Key_Dimension_Customer]
GO
ALTER TABLE [Fact].[Sale]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Sale_City_Key_Dimension_City] FOREIGN KEY([City Key])
REFERENCES [Dimension].[City] ([City Key])
GO
ALTER TABLE [Fact].[Sale] CHECK CONSTRAINT [FK_Fact_Sale_City_Key_Dimension_City]
GO
ALTER TABLE [Fact].[Sale]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Sale_Customer_Key_Dimension_Customer] FOREIGN KEY([Customer Key])
REFERENCES [Dimension].[Customer] ([Customer Key])
GO
ALTER TABLE [Fact].[Sale] CHECK CONSTRAINT [FK_Fact_Sale_Customer_Key_Dimension_Customer]
GO
ALTER TABLE [Fact].[Sale]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Sale_Delivery_Date_Key_Dimension_Date] FOREIGN KEY([Delivery Date Key])
REFERENCES [Dimension].[Date] ([Date])
GO
ALTER TABLE [Fact].[Sale] CHECK CONSTRAINT [FK_Fact_Sale_Delivery_Date_Key_Dimension_Date]
GO
ALTER TABLE [Fact].[Sale]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Sale_Invoice_Date_Key_Dimension_Date] FOREIGN KEY([Invoice Date Key])
REFERENCES [Dimension].[Date] ([Date])
GO
ALTER TABLE [Fact].[Sale] CHECK CONSTRAINT [FK_Fact_Sale_Invoice_Date_Key_Dimension_Date]
GO
ALTER TABLE [Fact].[Sale]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Sale_Salesperson_Key_Dimension_Employee] FOREIGN KEY([Salesperson Key])
REFERENCES [Dimension].[Employee] ([Employee Key])
GO
ALTER TABLE [Fact].[Sale] CHECK CONSTRAINT [FK_Fact_Sale_Salesperson_Key_Dimension_Employee]
GO
ALTER TABLE [Fact].[Sale]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Sale_Stock_Item_Key_Dimension_Stock Item] FOREIGN KEY([Stock Item Key])
REFERENCES [Dimension].[Stock Item] ([Stock Item Key])
GO
ALTER TABLE [Fact].[Sale] CHECK CONSTRAINT [FK_Fact_Sale_Stock_Item_Key_Dimension_Stock Item]
GO
ALTER TABLE [Fact].[Stock Holding]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Stock_Holding_Stock_Item_Key_Dimension_Stock Item] FOREIGN KEY([Stock Item Key])
REFERENCES [Dimension].[Stock Item] ([Stock Item Key])
GO
ALTER TABLE [Fact].[Stock Holding] CHECK CONSTRAINT [FK_Fact_Stock_Holding_Stock_Item_Key_Dimension_Stock Item]
GO
ALTER TABLE [Fact].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Transaction_Bill_To_Customer_Key_Dimension_Customer] FOREIGN KEY([Bill To Customer Key])
REFERENCES [Dimension].[Customer] ([Customer Key])
GO
ALTER TABLE [Fact].[Transaction] CHECK CONSTRAINT [FK_Fact_Transaction_Bill_To_Customer_Key_Dimension_Customer]
GO
ALTER TABLE [Fact].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Transaction_Customer_Key_Dimension_Customer] FOREIGN KEY([Customer Key])
REFERENCES [Dimension].[Customer] ([Customer Key])
GO
ALTER TABLE [Fact].[Transaction] CHECK CONSTRAINT [FK_Fact_Transaction_Customer_Key_Dimension_Customer]
GO
ALTER TABLE [Fact].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Transaction_Date_Key_Dimension_Date] FOREIGN KEY([Date Key])
REFERENCES [Dimension].[Date] ([Date])
GO
ALTER TABLE [Fact].[Transaction] CHECK CONSTRAINT [FK_Fact_Transaction_Date_Key_Dimension_Date]
GO
ALTER TABLE [Fact].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Transaction_Payment_Method_Key_Dimension_Payment Method] FOREIGN KEY([Payment Method Key])
REFERENCES [Dimension].[Payment Method] ([Payment Method Key])
GO
ALTER TABLE [Fact].[Transaction] CHECK CONSTRAINT [FK_Fact_Transaction_Payment_Method_Key_Dimension_Payment Method]
GO
ALTER TABLE [Fact].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Transaction_Supplier_Key_Dimension_Supplier] FOREIGN KEY([Supplier Key])
REFERENCES [Dimension].[Supplier] ([Supplier Key])
GO
ALTER TABLE [Fact].[Transaction] CHECK CONSTRAINT [FK_Fact_Transaction_Supplier_Key_Dimension_Supplier]
GO
ALTER TABLE [Fact].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Transaction_Transaction_Type_Key_Dimension_Transaction Type] FOREIGN KEY([Transaction Type Key])
REFERENCES [Dimension].[Transaction Type] ([Transaction Type Key])
GO
ALTER TABLE [Fact].[Transaction] CHECK CONSTRAINT [FK_Fact_Transaction_Transaction_Type_Key_Dimension_Transaction Type]
GO
/****** Object:  StoredProcedure [Application].[Configuration_ApplyPartitionedColumnstoreIndexing]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Application].[Configuration_ApplyPartitionedColumnstoreIndexing]
WITH EXECUTE AS OWNER
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    IF SERVERPROPERTY(N'IsXTPSupported') = 0 -- TODO !! - currently no separate test for columnstore
    BEGIN                                    -- but same editions with XTP support columnstore
        PRINT N'Warning: Columnstore indexes cannot be created on this edition.';
    END ELSE BEGIN -- if columnstore can be created
        DECLARE @SQL nvarchar(max) = N'';

        BEGIN TRY;

			IF NOT EXISTS (SELECT 1 FROM sys.partition_functions WHERE name = N'PF_Date')
			BEGIN
				SET @SQL =  N'
CREATE PARTITION FUNCTION PF_Date(date)
AS RANGE RIGHT
FOR VALUES (N''20120101'',N''20130101'',N''20140101'', N''20150101'', N''20160101'', N''20170101'');';
				EXECUTE (@SQL);
				PRINT N'Created partition function PF_Date';
			END;

			IF NOT EXISTS (SELECT 1 FROM sys.partition_schemes WHERE name = N'PS_Date')
			BEGIN
				-- for Azure DB, assign to primary filegroup
				IF SERVERPROPERTY('EngineEdition') = 5 
					SET @SQL =  N'
CREATE PARTITION SCHEME PS_Date
AS PARTITION PF_Date
ALL TO ([PRIMARY]);';				
				-- for other engine editions, assign to user data filegroup
				IF SERVERPROPERTY('EngineEdition') != 5 
					SET @SQL =  N'
CREATE PARTITION SCHEME PS_Date
AS PARTITION PF_Date
ALL TO ([USERDATA]);';
				EXECUTE (@SQL);
				PRINT N'Created partition scheme PS_Date';
			END;
			
            IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'CCX_Fact_Movement')
            BEGIN
				BEGIN TRAN;

                SET @SQL = N'

DROP INDEX [FK_Fact_Movement_Customer_Key] ON Fact.Movement;
DROP INDEX [FK_Fact_Movement_Date_Key] ON Fact.Movement;
DROP INDEX [FK_Fact_Movement_Stock_Item_Key] ON Fact.Movement;
DROP INDEX [FK_Fact_Movement_Supplier_Key] ON Fact.Movement;
DROP INDEX [FK_Fact_Movement_Transaction_Type_Key] ON Fact.Movement;
DROP INDEX [IX_Integration_Movement_WWI_Stock_Item_Transaction_ID] ON Fact.Movement;

ALTER TABLE Fact.Movement
DROP CONSTRAINT PK_Fact_Movement;

CREATE CLUSTERED INDEX CCX_Fact_Movement
ON Fact.Movement
(
	[Date Key]
)
ON PS_Date([Date Key]);

CREATE CLUSTERED COLUMNSTORE INDEX CCX_Fact_Movement
ON Fact.Movement WITH (DROP_EXISTING = ON)
ON PS_Date([Date Key]);

ALTER TABLE [Fact].[Movement]
ADD  CONSTRAINT [PK_Fact_Movement] PRIMARY KEY NONCLUSTERED
(
	[Movement Key],
	[Date Key]
)
ON PS_Date([Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Movement_Customer_Key]
ON [Fact].[Movement]
(
	[Customer Key]
)
ON PS_Date([Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Movement_Date_Key]
ON [Fact].[Movement]
(
	[Date Key]
)
ON PS_Date([Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Movement_Stock_Item_Key]
ON [Fact].[Movement]
(
	[Stock Item Key]
)
ON PS_Date([Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Movement_Supplier_Key]
ON [Fact].[Movement]
(
	[Supplier Key]
)
ON PS_Date([Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Movement_Transaction_Type_Key]
ON [Fact].[Movement]
(
	[Transaction Type Key]
)
ON PS_Date([Date Key]);

CREATE NONCLUSTERED INDEX [IX_Integration_Movement_WWI_Stock_Item_Transaction_ID]
ON [Fact].[Movement]
(
	[WWI Stock Item Transaction ID]
)
ON PS_Date([Date Key]);

DROP INDEX [FK_Fact_Order_City_Key] ON Fact.[Order];
DROP INDEX [FK_Fact_Order_Customer_Key] ON Fact.[Order];
DROP INDEX [FK_Fact_Order_Order_Date_Key] ON Fact.[Order];
DROP INDEX [FK_Fact_Order_Picked_Date_Key] ON Fact.[Order];
DROP INDEX [FK_Fact_Order_Picker_Key] ON Fact.[Order];
DROP INDEX [FK_Fact_Order_Salesperson_Key] ON Fact.[Order];
DROP INDEX [FK_Fact_Order_Stock_Item_Key] ON Fact.[Order];
DROP INDEX [IX_Integration_Order_WWI_Order_ID] ON Fact.[Order];

ALTER TABLE Fact.[Order]
DROP CONSTRAINT PK_Fact_Order;

CREATE CLUSTERED INDEX CCX_Fact_Order
ON Fact.[Order]
(
	[Order Date Key]
)
ON PS_Date([Order Date Key]);

CREATE CLUSTERED COLUMNSTORE INDEX CCX_Fact_Order
ON Fact.[Order] WITH (DROP_EXISTING = ON)
ON PS_Date([Order Date Key]);

ALTER TABLE [Fact].[Order]
ADD  CONSTRAINT [PK_Fact_Order] PRIMARY KEY NONCLUSTERED
(
	[Order Key],
	[Order Date Key]
)
ON PS_Date([Order Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Order_City_Key]
ON [Fact].[Order]
(
	[City Key]
)
ON PS_Date([Order Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Order_Customer_Key]
ON [Fact].[Order]
(
	[Customer Key]
)
ON PS_Date([Order Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Order_Order_Date_Key]
ON [Fact].[Order]
(
	[Order Date Key]
)
ON PS_Date([Order Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Order_Picked_Date_Key]
ON [Fact].[Order]
(
	[Picked Date Key]
)
ON PS_Date([Order Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Order_Picker_Key]
ON [Fact].[Order]
(
	[Picker Key] ASC
)
ON PS_Date([Order Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Order_Salesperson_Key]
ON [Fact].[Order]
(
	[Salesperson Key]
)
ON PS_Date([Order Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Order_Stock_Item_Key]
ON [Fact].[Order]
(
	[Stock Item Key]
)
ON PS_Date([Order Date Key]);

CREATE NONCLUSTERED INDEX [IX_Integration_Order_WWI_Order_ID]
ON [Fact].[Order]
(
	[WWI Order ID]
)
ON PS_Date([Order Date Key]);

DROP INDEX [FK_Fact_Purchase_Date_Key] ON Fact.Purchase;
DROP INDEX [FK_Fact_Purchase_Stock_Item_Key] ON Fact.Purchase;
DROP INDEX [FK_Fact_Purchase_Supplier_Key] ON Fact.Purchase;

ALTER TABLE Fact.Purchase
DROP CONSTRAINT PK_Fact_Purchase;

CREATE CLUSTERED INDEX CCX_Fact_Purchase
ON Fact.Purchase
(
	[Date Key]
)
ON PS_Date([Date Key]);

CREATE CLUSTERED COLUMNSTORE INDEX CCX_Fact_Purchase
ON Fact.Purchase WITH (DROP_EXISTING = ON)
ON PS_Date([Date Key]);

ALTER TABLE Fact.Purchase
ADD CONSTRAINT [PK_Fact_Purchase] PRIMARY KEY NONCLUSTERED
(
	[Purchase Key],
	[Date Key]
)
ON PS_Date([Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Purchase_Date_Key]
ON [Fact].[Purchase]
(
	[Date Key]
)
ON PS_Date([Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Purchase_Stock_Item_Key]
ON [Fact].[Purchase]
(
	[Stock Item Key]
)
ON PS_Date([Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Purchase_Supplier_Key]
ON [Fact].[Purchase]
(
	[Supplier Key]
)
ON PS_Date([Date Key]);

DROP INDEX [FK_Fact_Sale_Bill_To_Customer_Key] ON Fact.Sale;
DROP INDEX [FK_Fact_Sale_City_Key] ON Fact.Sale;
DROP INDEX [FK_Fact_Sale_Customer_Key] ON Fact.Sale;
DROP INDEX [FK_Fact_Sale_Delivery_Date_Key] ON Fact.Sale;
DROP INDEX [FK_Fact_Sale_Invoice_Date_Key] ON Fact.Sale;
DROP INDEX [FK_Fact_Sale_Salesperson_Key] ON Fact.Sale;
DROP INDEX [FK_Fact_Sale_Stock_Item_Key] ON Fact.Sale;

ALTER TABLE Fact.Sale
DROP CONSTRAINT PK_Fact_Sale;

CREATE CLUSTERED INDEX CCX_Fact_Sale
ON Fact.Sale
(
	[Invoice Date Key]
)
ON PS_Date([Invoice Date Key]);

CREATE CLUSTERED COLUMNSTORE INDEX CCX_Fact_Sale
ON Fact.Sale WITH (DROP_EXISTING = ON)
ON PS_Date([Invoice Date Key]);

ALTER TABLE Fact.Sale
ADD CONSTRAINT [PK_Fact_Sale] PRIMARY KEY NONCLUSTERED
(
	[Sale Key],
	[Invoice Date Key]
)
ON PS_Date([Invoice Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Sale_Bill_To_Customer_Key]
ON [Fact].[Sale]
(
	[Bill To Customer Key]
)
ON PS_Date([Invoice Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Sale_City_Key]
ON [Fact].[Sale]
(
	[City Key]
)
ON PS_Date([Invoice Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Sale_Customer_Key]
ON [Fact].[Sale]
(
	[Customer Key]
)
ON PS_Date([Invoice Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Sale_Delivery_Date_Key]
ON [Fact].[Sale]
(
	[Delivery Date Key]
)
ON PS_Date([Invoice Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Sale_Invoice_Date_Key]
ON [Fact].[Sale]
(
	[Invoice Date Key]
)
ON PS_Date([Invoice Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Sale_Salesperson_Key]
ON [Fact].[Sale]
(
	[Salesperson Key]
)
ON PS_Date([Invoice Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Sale_Stock_Item_Key]
ON [Fact].[Sale]
(
	[Stock Item Key]
)
ON PS_Date([Invoice Date Key]);

ALTER TABLE Fact.[Stock Holding]
DROP CONSTRAINT PK_Fact_Stock_Holding;

ALTER TABLE Fact.[Stock Holding]
ADD CONSTRAINT PK_Fact_Stock_Holding PRIMARY KEY NONCLUSTERED ([Stock Holding Key]);

CREATE CLUSTERED COLUMNSTORE INDEX CCX_Fact_Stock_Holding
ON Fact.[Stock Holding];

DROP INDEX [FK_Fact_Transaction_Bill_To_Customer_Key] ON Fact.[Transaction];
DROP INDEX [FK_Fact_Transaction_Customer_Key] ON Fact.[Transaction];
DROP INDEX [FK_Fact_Transaction_Date_Key] ON Fact.[Transaction];
DROP INDEX [FK_Fact_Transaction_Payment_Method_Key] ON Fact.[Transaction];
DROP INDEX [FK_Fact_Transaction_Supplier_Key] ON Fact.[Transaction];
DROP INDEX [FK_Fact_Transaction_Transaction_Type_Key] ON Fact.[Transaction];

ALTER TABLE Fact.[Transaction]
DROP CONSTRAINT PK_Fact_Transaction;

CREATE CLUSTERED INDEX CCX_Fact_Transaction
ON Fact.[Transaction]
(
	[Date Key]
)
ON PS_Date([Date Key]);

CREATE CLUSTERED COLUMNSTORE INDEX CCX_Fact_Transaction
ON Fact.[Transaction] WITH (DROP_EXISTING = ON)
ON PS_Date([Date Key]);

ALTER TABLE Fact.[Transaction]
ADD CONSTRAINT [PK_Fact_Transaction] PRIMARY KEY NONCLUSTERED
(
	[Transaction Key],
	[Date Key]
)
ON PS_Date([Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Transaction_Bill_To_Customer_Key]
ON [Fact].[Transaction]
(
	[Bill To Customer Key]
)
ON PS_Date([Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Transaction_Customer_Key]
ON [Fact].[Transaction]
(
	[Customer Key]
)
ON PS_Date([Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Transaction_Date_Key]
ON [Fact].[Transaction]
(
	[Date Key]
)
ON PS_Date([Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Transaction_Payment_Method_Key]
ON [Fact].[Transaction]
(
	[Payment Method Key]
)
ON PS_Date([Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Transaction_Supplier_Key]
ON [Fact].[Transaction]
(
	[Supplier Key]
)
ON PS_Date([Date Key]);

CREATE NONCLUSTERED INDEX [FK_Fact_Transaction_Transaction_Type_Key]
ON [Fact].[Transaction]
(
	[Transaction Type Key]
)
ON PS_Date([Date Key]);';
                EXECUTE (@SQL);

				COMMIT;

                PRINT N'Applied partitioned columnstore indexing';
            END;

        END TRY
        BEGIN CATCH
            PRINT N'Unable to apply partitioned columnstore indexing';
            THROW;
        END CATCH;
    END; -- of partitioned columnstore is allowed
END;
GO
/****** Object:  StoredProcedure [Application].[Configuration_ApplyPolybase]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Application].[Configuration_ApplyPolybase]
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    IF SERVERPROPERTY(N'IsPolybaseInstalled') = 0
    BEGIN
        PRINT N'Warning: Either Polybase cannot be created on this edition or it has not been installed.';
	END ELSE BEGIN -- if installed
		IF (SELECT value FROM sys.configurations WHERE name = 'hadoop connectivity') NOT IN (1, 4, 7)
		BEGIN
	        PRINT N'Warning: Hadoop connectivity has not been enabled. It must be set to 1, 4, or 7 for Azure Storage connectivity.';
		END ELSE BEGIN -- if Polybase can be created

			DECLARE @SQL nvarchar(max) = N'';

			BEGIN TRY

				SET @SQL = N'
CREATE EXTERNAL DATA SOURCE AzureStorage
WITH
(
	TYPE=HADOOP, LOCATION = ''wasbs://data@sqldwdatasets.blob.core.windows.net''
);';
				EXECUTE (@SQL);

				SET @SQL = N'
CREATE EXTERNAL FILE FORMAT CommaDelimitedTextFileFormat
WITH
(
	FORMAT_TYPE = DELIMITEDTEXT,
	FORMAT_OPTIONS
	(
		FIELD_TERMINATOR = '',''
	)
);';
				EXECUTE (@SQL);

				SET @SQL = N'
CREATE EXTERNAL TABLE dbo.CityPopulationStatistics
(
	CityID int NOT NULL,
	StateProvinceCode nvarchar(5) NOT NULL,
	CityName nvarchar(50) NOT NULL,
	YearNumber int NOT NULL,
	LatestRecordedPopulation bigint NULL
)
WITH
(
	LOCATION = ''/'',
	DATA_SOURCE = AzureStorage,
	FILE_FORMAT = CommaDelimitedTextFileFormat,
	REJECT_TYPE = VALUE,
	REJECT_VALUE = 4 -- skipping 1 header row per file
);';
				EXECUTE (@SQL);

	        END TRY
			BEGIN CATCH
				PRINT N'Unable to apply Polybase connectivity to Azure storage';
				THROW;
			END CATCH;
		END; -- if connectivity enabled
    END; -- of Polybase is allowed and installed
END;
GO
/****** Object:  StoredProcedure [Application].[Configuration_ConfigureForEnterpriseEdition]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Application].[Configuration_ConfigureForEnterpriseEdition]
AS
BEGIN

    EXEC [Application].Configuration_ApplyPartitionedColumnstoreIndexing;

    EXEC [Application].Configuration_EnableInMemory;

	EXEC [Application].Configuration_ApplyPolybase;

END;
GO
/****** Object:  StoredProcedure [Application].[Configuration_EnableInMemory]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Application].[Configuration_EnableInMemory]
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    IF SERVERPROPERTY(N'IsXTPSupported') = 0
    BEGIN
        PRINT N'Warning: In-memory tables cannot be created on this edition.';
    END ELSE BEGIN -- if in-memory can be created

		DECLARE @SQL nvarchar(max) = N'';

		BEGIN TRY
			IF CAST(SERVERPROPERTY(N'EngineEdition') AS int) <> 5   -- Not an Azure SQL DB
			BEGIN
				DECLARE @SQLDataFolder nvarchar(max) = (SELECT SUBSTRING(df.physical_name, 1, CHARINDEX(N'WideWorldImportersDW.mdf', df.physical_name, 1) - 1)
				                                        FROM sys.database_files AS df
				                                        WHERE df.file_id = 1);
				DECLARE @MemoryOptimizedFilegroupFolder nvarchar(max) = @SQLDataFolder + N'WideWorldImportersDW_InMemory_Data_1';

				IF NOT EXISTS (SELECT 1 FROM sys.filegroups WHERE name = N'WWIDW_InMemory_Data')
				BEGIN
				    SET @SQL = N'
ALTER DATABASE CURRENT
ADD FILEGROUP WWIDW_InMemory_Data CONTAINS MEMORY_OPTIMIZED_DATA;';
					EXECUTE (@SQL);

					SET @SQL = N'
ALTER DATABASE CURRENT
ADD FILE (name = N''WWIDW_InMemory_Data_1'', filename = '''
		                 + @MemoryOptimizedFilegroupFolder + N''')
TO FILEGROUP WWIDW_InMemory_Data;';
					EXECUTE (@SQL);

				END;
            END;

			SET @SQL = N'
ALTER DATABASE CURRENT
SET MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = ON;';
			EXECUTE (@SQL);

            IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'Customer_Staging' AND is_memory_optimized <> 0)
            BEGIN

                SET @SQL = N'
DROP TABLE IF EXISTS Integration.Customer_Staging;';
                EXECUTE (@SQL);

                SET @SQL = N'
CREATE TABLE [Integration].[Customer_Staging]
(
	[Customer Staging Key] [int] IDENTITY(1,1) NOT NULL,
	[WWI Customer ID] [int] NOT NULL,
	[Customer] [nvarchar](100) NOT NULL,
	[Bill To Customer] [nvarchar](100) NOT NULL,
	[Category] [nvarchar](50) NOT NULL,
	[Buying Group] [nvarchar](50) NOT NULL,
	[Primary Contact] [nvarchar](50) NOT NULL,
	[Postal Code] [nvarchar](10) NOT NULL,
	[Valid From] [datetime2](7) NOT NULL,
	[Valid To] [datetime2](7) NOT NULL,
    CONSTRAINT PK_Integration_Customer_Staging PRIMARY KEY NONCLUSTERED ([Customer Staging Key])
) WITH (MEMORY_OPTIMIZED = ON ,DURABILITY = SCHEMA_ONLY);';
                EXECUTE (@SQL);
			END;

            IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'Employee_Staging' AND is_memory_optimized <> 0)
            BEGIN

                SET @SQL = N'
DROP TABLE IF EXISTS Integration.Employee_Staging;';
                EXECUTE (@SQL);

                SET @SQL = N'
CREATE TABLE [Integration].[Employee_Staging]
(
	[Employee Staging Key] [int] IDENTITY(1,1) NOT NULL,
	[WWI Employee ID] [int] NOT NULL,
	[Employee] [nvarchar](50) NOT NULL,
	[Preferred Name] [nvarchar](50) NOT NULL,
	[Is Salesperson] [bit] NOT NULL,
	[Photo] [varbinary](max) NULL,
	[Valid From] [datetime2](7) NOT NULL,
	[Valid To] [datetime2](7) NOT NULL,
    CONSTRAINT PK_Integration_Employee_Staging PRIMARY KEY NONCLUSTERED ([Employee Staging Key])
) WITH (MEMORY_OPTIMIZED = ON ,DURABILITY = SCHEMA_ONLY);';
                EXECUTE (@SQL);
			END;

			IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'Movement_Staging' AND is_memory_optimized <> 0)
            BEGIN

                SET @SQL = N'
DROP TABLE IF EXISTS Integration.Movement_Staging;';
                EXECUTE (@SQL);

                SET @SQL = N'
CREATE TABLE [Integration].[Movement_Staging]
(
	[Movement Staging Key] [bigint] IDENTITY(1,1) NOT NULL,
	[Date Key] [date] NULL,
	[Stock Item Key] [int] NULL,
	[Customer Key] [int] NULL,
	[Supplier Key] [int] NULL,
	[Transaction Type Key] [int] NULL,
	[WWI Stock Item Transaction ID] [int] NULL,
	[WWI Invoice ID] [int] NULL,
	[WWI Purchase Order ID] [int] NULL,
	[Quantity] [int] NULL,
	[WWI Stock Item ID] [int] NULL,
	[WWI Customer ID] [int] NULL,
	[WWI Supplier ID] [int] NULL,
	[WWI Transaction Type ID] [int] NULL,
	[Last Modifed When] [datetime2](7) NULL,
    CONSTRAINT PK_Integration_Movement_Staging PRIMARY KEY NONCLUSTERED ([Movement Staging Key])
) WITH (MEMORY_OPTIMIZED = ON ,DURABILITY = SCHEMA_ONLY);';
                EXECUTE (@SQL);
			END;

			IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'Order_Staging' AND is_memory_optimized <> 0)
            BEGIN

                SET @SQL = N'
DROP TABLE IF EXISTS Integration.Order_Staging;';
                EXECUTE (@SQL);

                SET @SQL = N'
CREATE TABLE [Integration].[Order_Staging](
	[Order Staging Key] [bigint] IDENTITY(1,1) NOT NULL,
	[City Key] [int] NULL,
	[Customer Key] [int] NULL,
	[Stock Item Key] [int] NULL,
	[Order Date Key] [date] NULL,
	[Picked Date Key] [date] NULL,
	[Salesperson Key] [int] NULL,
	[Picker Key] [int] NULL,
	[WWI Order ID] [int] NULL,
	[WWI Backorder ID] [int] NULL,
	[Description] [nvarchar](100) NULL,
	[Package] [nvarchar](50) NULL,
	[Quantity] [int] NULL,
	[Unit Price] [decimal](18, 2) NULL,
	[Tax Rate] [decimal](18, 3) NULL,
	[Total Excluding Tax] [decimal](18, 2) NULL,
	[Tax Amount] [decimal](18, 2) NULL,
	[Total Including Tax] [decimal](18, 2) NULL,
	[Lineage Key] [int] NULL,
	[WWI City ID] [int] NULL,
	[WWI Customer ID] [int] NULL,
	[WWI Stock Item ID] [int] NULL,
	[WWI Salesperson ID] [int] NULL,
	[WWI Picker ID] [int] NULL,
	[Last Modified When] [datetime2](7) NULL,
    CONSTRAINT PK_Integration_Order_Staging PRIMARY KEY NONCLUSTERED ([Order Staging Key])
) WITH (MEMORY_OPTIMIZED = ON ,DURABILITY = SCHEMA_ONLY);';
                EXECUTE (@SQL);
			END;

			IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'PaymentMethod_Staging' AND is_memory_optimized <> 0)
            BEGIN

                SET @SQL = N'
DROP TABLE IF EXISTS Integration.PaymentMethod_Staging;';
                EXECUTE (@SQL);

                SET @SQL = N'
CREATE TABLE [Integration].[PaymentMethod_Staging]
(
	[Payment Method Staging Key] [int] IDENTITY(1,1) NOT NULL,
	[WWI Payment Method ID] [int] NOT NULL,
	[Payment Method] [nvarchar](50) NOT NULL,
	[Valid From] [datetime2](7) NOT NULL,
	[Valid To] [datetime2](7) NOT NULL,
    CONSTRAINT PK_Integration_Payment_Method_Staging PRIMARY KEY NONCLUSTERED ([Payment Method Staging Key])
) WITH (MEMORY_OPTIMIZED = ON ,DURABILITY = SCHEMA_ONLY);';
                EXECUTE (@SQL);
			END;

			IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'Purchase_Staging' AND is_memory_optimized <> 0)
            BEGIN

                SET @SQL = N'
DROP TABLE IF EXISTS Integration.Purchase_Staging;';
                EXECUTE (@SQL);

                SET @SQL = N'
CREATE TABLE [Integration].[Purchase_Staging]
(
	[Purchase Staging Key] [bigint] IDENTITY(1,1) NOT NULL,
	[Date Key] [date] NULL,
	[Supplier Key] [int] NULL,
	[Stock Item Key] [int] NULL,
	[WWI Purchase Order ID] [int] NULL,
	[Ordered Outers] [int] NULL,
	[Ordered Quantity] [int] NULL,
	[Received Outers] [int] NULL,
	[Package] [nvarchar](50) NULL,
	[Is Order Finalized] [bit] NULL,
	[WWI Supplier ID] [int] NULL,
	[WWI Stock Item ID] [int] NULL,
	[Last Modified When] [datetime2](7) NULL,
    CONSTRAINT PK_Integration_Purchase_Staging PRIMARY KEY NONCLUSTERED ([Purchase Staging Key])
) WITH (MEMORY_OPTIMIZED = ON ,DURABILITY = SCHEMA_ONLY);';
                EXECUTE (@SQL);
			END;

			IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'Sale_Staging' AND is_memory_optimized <> 0)
            BEGIN

                SET @SQL = N'
DROP TABLE IF EXISTS Integration.Sale_Staging;';
                EXECUTE (@SQL);

                SET @SQL = N'
CREATE TABLE [Integration].[Sale_Staging]
(
	[Sale Staging Key] [bigint] IDENTITY(1,1) NOT NULL,
	[City Key] [int] NULL,
	[Customer Key] [int] NULL,
	[Bill To Customer Key] [int] NULL,
	[Stock Item Key] [int] NULL,
	[Invoice Date Key] [date] NULL,
	[Delivery Date Key] [date] NULL,
	[Salesperson Key] [int] NULL,
	[WWI Invoice ID] [int] NULL,
	[Description] [nvarchar](100) NULL,
	[Package] [nvarchar](50) NULL,
	[Quantity] [int] NULL,
	[Unit Price] [decimal](18, 2) NULL,
	[Tax Rate] [decimal](18, 3) NULL,
	[Total Excluding Tax] [decimal](18, 2) NULL,
	[Tax Amount] [decimal](18, 2) NULL,
	[Profit] [decimal](18, 2) NULL,
	[Total Including Tax] [decimal](18, 2) NULL,
	[Total Dry Items] [int] NULL,
	[Total Chiller Items] [int] NULL,
	[WWI City ID] [int] NULL,
	[WWI Customer ID] [int] NULL,
	[WWI Bill To Customer ID] [int] NULL,
	[WWI Stock Item ID] [int] NULL,
	[WWI Salesperson ID] [int] NULL,
	[Last Modified When] [datetime2](7) NULL,
    CONSTRAINT PK_Integration_Sale_Staging PRIMARY KEY NONCLUSTERED ([Sale Staging Key])
) WITH (MEMORY_OPTIMIZED = ON ,DURABILITY = SCHEMA_ONLY);';
                EXECUTE (@SQL);
			END;

			IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'StockHolding_Staging' AND is_memory_optimized <> 0)
            BEGIN

                SET @SQL = N'
DROP TABLE IF EXISTS Integration.StockHolding_Staging;';
                EXECUTE (@SQL);

                SET @SQL = N'
CREATE TABLE [Integration].[StockHolding_Staging]
(
	[Stock Holding Staging Key] [bigint] IDENTITY(1,1) NOT NULL,
	[Stock Item Key] [int] NULL,
	[Quantity On Hand] [int] NULL,
	[Bin Location] [nvarchar](20) NULL,
	[Last Stocktake Quantity] [int] NULL,
	[Last Cost Price] [decimal](18, 2) NULL,
	[Reorder Level] [int] NULL,
	[Target Stock Level] [int] NULL,
	[WWI Stock Item ID] [int] NULL,
    CONSTRAINT PK_Integration_Stock_Holding_Staging PRIMARY KEY NONCLUSTERED ([Stock Holding Staging Key])
) WITH (MEMORY_OPTIMIZED = ON ,DURABILITY = SCHEMA_ONLY);';
                EXECUTE (@SQL);
			END;

			IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'StockItem_Staging' AND is_memory_optimized <> 0)
            BEGIN

                SET @SQL = N'
DROP TABLE IF EXISTS Integration.StockItem_Staging;';
                EXECUTE (@SQL);

                SET @SQL = N'
CREATE TABLE [Integration].[StockItem_Staging]
(
	[Stock Item Staging Key] [int] IDENTITY(1,1) NOT NULL,
	[WWI Stock Item ID] [int] NOT NULL,
	[Stock Item] [nvarchar](100) NOT NULL,
	[Color] [nvarchar](20) NOT NULL,
	[Selling Package] [nvarchar](50) NOT NULL,
	[Buying Package] [nvarchar](50) NOT NULL,
	[Brand] [nvarchar](50) NOT NULL,
	[Size] [nvarchar](20) NOT NULL,
	[Lead Time Days] [int] NOT NULL,
	[Quantity Per Outer] [int] NOT NULL,
	[Is Chiller Stock] [bit] NOT NULL,
	[Barcode] [nvarchar](50) NULL,
	[Tax Rate] [decimal](18, 3) NOT NULL,
	[Unit Price] [decimal](18, 2) NOT NULL,
	[Recommended Retail Price] [decimal](18, 2) NULL,
	[Typical Weight Per Unit] [decimal](18, 3) NOT NULL,
	[Photo] [varbinary](max) NULL,
	[Valid From] [datetime2](7) NOT NULL,
	[Valid To] [datetime2](7) NOT NULL,
    CONSTRAINT PK_Integration_Stock_Item_Staging PRIMARY KEY NONCLUSTERED ([Stock Item Staging Key])
) WITH (MEMORY_OPTIMIZED = ON ,DURABILITY = SCHEMA_ONLY);';
                EXECUTE (@SQL);
			END;

			IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'Supplier_Staging' AND is_memory_optimized <> 0)
            BEGIN

                SET @SQL = N'
DROP TABLE IF EXISTS Integration.Supplier_Staging;';
                EXECUTE (@SQL);

                SET @SQL = N'
CREATE TABLE [Integration].[Supplier_Staging]
(
	[Supplier Staging Key] [int] IDENTITY(1,1) NOT NULL,
	[WWI Supplier ID] [int] NOT NULL,
	[Supplier] [nvarchar](100) NOT NULL,
	[Category] [nvarchar](50) NOT NULL,
	[Primary Contact] [nvarchar](50) NOT NULL,
	[Supplier Reference] [nvarchar](20) NULL,
	[Payment Days] [int] NOT NULL,
	[Postal Code] [nvarchar](10) NOT NULL,
	[Valid From] [datetime2](7) NOT NULL,
	[Valid To] [datetime2](7) NOT NULL,
    CONSTRAINT PK_Integration_Supplier_Staging PRIMARY KEY NONCLUSTERED ([Supplier Staging Key])
) WITH (MEMORY_OPTIMIZED = ON ,DURABILITY = SCHEMA_ONLY);';
                EXECUTE (@SQL);
			END;

			IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'Transaction_Staging' AND is_memory_optimized <> 0)
            BEGIN

                SET @SQL = N'
DROP TABLE IF EXISTS Integration.Transaction_Staging;';
                EXECUTE (@SQL);

                SET @SQL = N'
CREATE TABLE [Integration].[Transaction_Staging]
(
	[Transaction Staging Key] [bigint] IDENTITY(1,1) NOT NULL,
	[Date Key] [date] NULL,
	[Customer Key] [int] NULL,
	[Bill To Customer Key] [int] NULL,
	[Supplier Key] [int] NULL,
	[Transaction Type Key] [int] NULL,
	[Payment Method Key] [int] NULL,
	[WWI Customer Transaction ID] [int] NULL,
	[WWI Supplier Transaction ID] [int] NULL,
	[WWI Invoice ID] [int] NULL,
	[WWI Purchase Order ID] [int] NULL,
	[Supplier Invoice Number] [nvarchar](20) NULL,
	[Total Excluding Tax] [decimal](18, 2) NULL,
	[Tax Amount] [decimal](18, 2) NULL,
	[Total Including Tax] [decimal](18, 2) NULL,
	[Outstanding Balance] [decimal](18, 2) NULL,
	[Is Finalized] [bit] NULL,
	[WWI Customer ID] [int] NULL,
	[WWI Bill To Customer ID] [int] NULL,
	[WWI Supplier ID] [int] NULL,
	[WWI Transaction Type ID] [int] NULL,
	[WWI Payment Method ID] [int] NULL,
	[Last Modified When] [datetime2](7) NULL,
    CONSTRAINT PK_Integration_Transaction_Staging PRIMARY KEY NONCLUSTERED ([Transaction Staging Key])
) WITH (MEMORY_OPTIMIZED = ON ,DURABILITY = SCHEMA_ONLY);';
                EXECUTE (@SQL);
			END;

			IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'TransactionType_Staging' AND is_memory_optimized <> 0)
            BEGIN

                SET @SQL = N'
DROP TABLE IF EXISTS Integration.TransactionType_Staging;';
                EXECUTE (@SQL);

                SET @SQL = N'
CREATE TABLE [Integration].[TransactionType_Staging]
(
	[Transaction Type Staging Key] [int] IDENTITY(1,1) NOT NULL,
	[WWI Transaction Type ID] [int] NOT NULL,
	[Transaction Type] [nvarchar](50) NOT NULL,
	[Valid From] [datetime2](7) NOT NULL,
	[Valid To] [datetime2](7) NOT NULL
    CONSTRAINT PK_Integration_Transaction_Type_Staging PRIMARY KEY NONCLUSTERED ([Transaction Type Staging Key])
) WITH (MEMORY_OPTIMIZED = ON ,DURABILITY = SCHEMA_ONLY);';
                EXECUTE (@SQL);
			END;

        END TRY
        BEGIN CATCH
            PRINT N'Unable to apply in-memory tables';
            THROW;
        END CATCH;
    END; -- of in-memory is allowed
END;
GO
/****** Object:  StoredProcedure [Application].[Configuration_PopulateLargeSaleTable]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Application].[Configuration_PopulateLargeSaleTable]
@EstimatedRowsFor2012 bigint = 12000000
WITH EXECUTE AS OWNER
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

	EXEC Integration.PopulateDateDimensionForYear 2012;
	DECLARE @ReturnValue int;

	EXEC @ReturnValue = [Application].Configuration_ApplyPartitionedColumnstoreIndexing;
	DECLARE @LineageKey int = NEXT VALUE FOR Sequences.LineageKey;

	INSERT Integration.Lineage
		([Lineage Key], [Data Load Started], [Table Name], [Data Load Completed], [Was Successful],
		 [Source System Cutoff Time])
	VALUES
		(@LineageKey, SYSDATETIME(), N'Sale', NULL, 0, '20121231')

	DECLARE @OrderCounter bigint = 0;
	DECLARE @NumberOfSalesPerDay bigint = @EstimatedRowsFor2012 / 365;
	DECLARE @DateCounter date = '20120101';
	DECLARE @StartingSaleKey bigint;
	DECLARE @MaximumSaleKey bigint = (SELECT MAX([Sale Key]) FROM Fact.Sale);

	PRINT 'Targeting ' + CAST(@NumberOfSalesPerDay AS varchar(20)) + ' sales per day.';
	IF @NumberOfSalesPerDay > 50000
	BEGIN
		PRINT 'WARNING: Limiting sales to 40000 per day';
		SET @NumberOfSalesPerDay = 50000;
	END;

	DECLARE @OutputCounter varchar(20);


-- DROP CONSTRAINTS
	ALTER TABLE [Fact].[Sale] DROP CONSTRAINT [FK_Fact_Sale_City_Key_Dimension_City]
	ALTER TABLE [Fact].[Sale] DROP CONSTRAINT [FK_Fact_Sale_Customer_Key_Dimension_Customer]
	ALTER TABLE [Fact].[Sale] DROP CONSTRAINT [FK_Fact_Sale_Delivery_Date_Key_Dimension_Date]
	ALTER TABLE [Fact].[Sale] DROP CONSTRAINT [FK_Fact_Sale_Invoice_Date_Key_Dimension_Date]
	ALTER TABLE [Fact].[Sale] DROP CONSTRAINT [FK_Fact_Sale_Salesperson_Key_Dimension_Employee]
	ALTER TABLE [Fact].[Sale] DROP CONSTRAINT [FK_Fact_Sale_Stock_Item_Key_Dimension_Stock Item]
	ALTER TABLE [Fact].[Sale] DROP CONSTRAINT [FK_Fact_Sale_Bill_To_Customer_Key_Dimension_Customer]
	ALTER TABLE [Fact].[Sale] DROP CONSTRAINT [PK_Fact_Sale]
	DROP INDEX  IF EXISTS [FK_Fact_Sale_Bill_To_Customer_Key] ON [Fact].[Sale]
	DROP INDEX  IF EXISTS [FK_Fact_Sale_City_Key] ON [Fact].[Sale]
	DROP INDEX  IF EXISTS [FK_Fact_Sale_Customer_Key] ON [Fact].[Sale]
	DROP INDEX  IF EXISTS [FK_Fact_Sale_Delivery_Date_Key] ON [Fact].[Sale]
	DROP INDEX  IF EXISTS [FK_Fact_Sale_Invoice_Date_Key] ON [Fact].[Sale]
	DROP INDEX  IF EXISTS [FK_Fact_Sale_Salesperson_Key] ON [Fact].[Sale]
	DROP INDEX  IF EXISTS [FK_Fact_Sale_Stock_Item_Key] ON [Fact].[Sale]

	WHILE @DateCounter < '20121231'
	BEGIN
		SET @OutputCounter = CONVERT(varchar(20), @DateCounter, 112);
		RAISERROR(@OutputCounter, 0, 1) WITH NOWAIT;

		SET @StartingSaleKey = @MaximumSaleKey - @NumberOfSalesPerDay - FLOOR(RAND() * 20000);
		SET @OrderCounter = 0;

		INSERT Fact.Sale WITH (TABLOCK)
			([City Key], [Customer Key], [Bill To Customer Key], [Stock Item Key], [Invoice Date Key],
			 [Delivery Date Key], [Salesperson Key], [WWI Invoice ID], [Description],
			 Package, Quantity, [Unit Price], [Tax Rate], [Total Excluding Tax],
			 [Tax Amount], Profit, [Total Including Tax], [Total Dry Items], [Total Chiller Items],
			 [Lineage Key])
		SELECT TOP(@NumberOfSalesPerDay)
			   [City Key], [Customer Key], [Bill To Customer Key], [Stock Item Key], @DateCounter,
			   DATEADD(day, 1, @DateCounter), [Salesperson Key], [WWI Invoice ID], [Description],
			   Package, Quantity, [Unit Price], [Tax Rate], [Total Excluding Tax],
			   [Tax Amount], Profit, [Total Including Tax], [Total Dry Items], [Total Chiller Items],
			   @LineageKey
		FROM Fact.Sale
		WHERE [Sale Key] > @StartingSaleKey
			and [Invoice Date Key] >='2013-01-01'
		ORDER BY [Sale Key];

		SET @DateCounter = DATEADD(day, 1, @DateCounter);
	END;

	RAISERROR('Compressing all open Rowgroups', 0, 1) WITH NOWAIT;

	ALTER INDEX CCX_Fact_Sale
	ON Fact.Sale
	REORGANIZE WITH (COMPRESS_ALL_ROW_GROUPS = ON);

	UPDATE Integration.Lineage
		SET [Data Load Completed] = SYSDATETIME(),
		    [Was Successful] = 1;

	-- Add back Constraints
	RAISERROR('Adding Constraints', 0, 1) WITH NOWAIT;

	ALTER TABLE [Fact].[Sale]
	ADD CONSTRAINT [PK_Fact_Sale] PRIMARY KEY NONCLUSTERED
	(
		[Sale Key] ASC,
		[Invoice Date Key] ASC
	);

	ALTER TABLE [Fact].[Sale]
	WITH CHECK ADD CONSTRAINT [FK_Fact_Sale_Bill_To_Customer_Key_Dimension_Customer]
	FOREIGN KEY([Bill To Customer Key])
	REFERENCES [Dimension].[Customer] ([Customer Key]);

	ALTER TABLE [Fact].[Sale] CHECK CONSTRAINT [FK_Fact_Sale_Bill_To_Customer_Key_Dimension_Customer];

	ALTER TABLE [Fact].[Sale]
	WITH CHECK ADD CONSTRAINT [FK_Fact_Sale_Stock_Item_Key_Dimension_Stock Item]
	FOREIGN KEY([Stock Item Key])
	REFERENCES [Dimension].[Stock Item] ([Stock Item Key]);

	ALTER TABLE [Fact].[Sale] CHECK CONSTRAINT [FK_Fact_Sale_Stock_Item_Key_Dimension_Stock Item];

	ALTER TABLE [Fact].[Sale]
	WITH CHECK ADD  CONSTRAINT [FK_Fact_Sale_Salesperson_Key_Dimension_Employee]
	FOREIGN KEY([Salesperson Key])
	REFERENCES [Dimension].[Employee] ([Employee Key]);

	ALTER TABLE [Fact].[Sale] CHECK CONSTRAINT [FK_Fact_Sale_Salesperson_Key_Dimension_Employee];

	ALTER TABLE [Fact].[Sale]
	WITH CHECK ADD  CONSTRAINT [FK_Fact_Sale_Invoice_Date_Key_Dimension_Date]
	FOREIGN KEY([Invoice Date Key])
	REFERENCES [Dimension].[Date] ([Date]);

	ALTER TABLE [Fact].[Sale] CHECK CONSTRAINT [FK_Fact_Sale_Invoice_Date_Key_Dimension_Date];

	ALTER TABLE [Fact].[Sale]
	WITH CHECK ADD CONSTRAINT [FK_Fact_Sale_Delivery_Date_Key_Dimension_Date]
	FOREIGN KEY([Delivery Date Key])
	REFERENCES [Dimension].[Date] ([Date]);

	ALTER TABLE [Fact].[Sale] CHECK CONSTRAINT [FK_Fact_Sale_Delivery_Date_Key_Dimension_Date];

	ALTER TABLE [Fact].[Sale]
	WITH CHECK ADD CONSTRAINT [FK_Fact_Sale_Customer_Key_Dimension_Customer]
	FOREIGN KEY([Customer Key])
	REFERENCES [Dimension].[Customer] ([Customer Key]);

	ALTER TABLE [Fact].[Sale] CHECK CONSTRAINT [FK_Fact_Sale_Customer_Key_Dimension_Customer];

	ALTER TABLE [Fact].[Sale]
	WITH CHECK ADD  CONSTRAINT [FK_Fact_Sale_City_Key_Dimension_City]
	FOREIGN KEY([City Key])
	REFERENCES [Dimension].[City] ([City Key]);

	ALTER TABLE [Fact].[Sale] CHECK CONSTRAINT [FK_Fact_Sale_City_Key_Dimension_City];

	-- Recreate indexes
	RAISERROR('Adding Non-clustered Indexes', 0, 1) WITH NOWAIT;
	CREATE NONCLUSTERED INDEX [FK_Fact_Sale_Salesperson_Key] ON [Fact].[Sale] ([Salesperson Key] ASC);
	CREATE NONCLUSTERED INDEX [FK_Fact_Sale_Invoice_Date_Key] ON [Fact].[Sale] ([Invoice Date Key] ASC);
	CREATE NONCLUSTERED INDEX [FK_Fact_Sale_Delivery_Date_Key] ON [Fact].[Sale] ([Delivery Date Key] ASC);
	CREATE NONCLUSTERED INDEX [FK_Fact_Sale_Bill_To_Customer_Key] ON [Fact].[Sale] ([Bill To Customer Key] ASC);
	CREATE NONCLUSTERED INDEX [FK_Fact_Sale_City_Key] ON [Fact].[Sale] ([City Key] ASC);
	CREATE NONCLUSTERED INDEX [FK_Fact_Sale_Customer_Key] ON [Fact].[Sale] ([Customer Key] ASC);

	RETURN 0;
END;
GO
/****** Object:  StoredProcedure [Application].[Configuration_ReseedETL]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Application].[Configuration_ReseedETL]
WITH EXECUTE AS OWNER
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @StartingETLCutoffTime datetime2(7) = '20121231';
	DECLARE @StartOfTime datetime2(7) = '20130101';
	DECLARE @EndOfTime datetime2(7) =  '99991231 23:59:59.9999999';

	UPDATE Integration.[ETL Cutoff]
		SET [Cutoff Time] = @StartingETLCutoffTime;

	TRUNCATE TABLE Fact.Movement;
	TRUNCATE TABLE Fact.[Order];
	TRUNCATE TABLE Fact.Purchase;
	TRUNCATE TABLE Fact.Sale;
	TRUNCATE TABLE Fact.[Stock Holding];
	TRUNCATE TABLE Fact.[Transaction];

	DELETE Dimension.City;
	DELETE Dimension.Customer;
	DELETE Dimension.Employee;
	DELETE Dimension.[Payment Method];
	DELETE Dimension.[Stock Item];
	DELETE Dimension.Supplier;
	DELETE Dimension.[Transaction Type];

    INSERT Dimension.City
        ([City Key], [WWI City ID], City, [State Province], Country, Continent, [Sales Territory], Region, Subregion,
         [Location], [Latest Recorded Population], [Valid From], [Valid To], [Lineage Key])
    VALUES
        (0, 0, N'Unknown', N'N/A', N'N/A', N'N/A', N'N/A', N'N/A', N'N/A',
         NULL, 0, @StartOfTime, @EndOfTime, 0);

    INSERT Dimension.Customer
        ([Customer Key], [WWI Customer ID], [Customer], [Bill To Customer], Category, [Buying Group],
         [Primary Contact], [Postal Code], [Valid From], [Valid To], [Lineage Key])
    VALUES
        (0, 0, N'Unknown', N'N/A', N'N/A', N'N/A',
         N'N/A', N'N/A', @StartOfTime, @EndOfTime, 0);

    INSERT Dimension.Employee
        ([Employee Key], [WWI Employee ID], Employee, [Preferred Name],
         [Is Salesperson], Photo, [Valid From], [Valid To], [Lineage Key])
    VALUES
        (0, 0, N'Unknown', N'N/A',
         0, NULL, @StartOfTime, @EndOfTime, 0);

    INSERT Dimension.[Payment Method]
        ([Payment Method Key], [WWI Payment Method ID], [Payment Method], [Valid From], [Valid To], [Lineage Key])
    VALUES
        (0, 0, N'Unknown', @StartOfTime, @EndOfTime, 0);

    INSERT Dimension.[Stock Item]
        ([Stock Item Key], [WWI Stock Item ID], [Stock Item], Color, [Selling Package], [Buying Package],
         Brand, Size, [Lead Time Days], [Quantity Per Outer], [Is Chiller Stock],
         Barcode, [Tax Rate], [Unit Price], [Recommended Retail Price], [Typical Weight Per Unit],
         Photo, [Valid From], [Valid To], [Lineage Key])
    VALUES
        (0, 0, N'Unknown', N'N/A', N'N/A', N'N/A',
         N'N/A', N'N/A', 0, 0, 0,
         N'N/A', 0, 0, 0, 0,
         NULL, @StartOfTime, @EndOfTime, 0);

    INSERT Dimension.[Supplier]
        ([Supplier Key], [WWI Supplier ID], Supplier, Category, [Primary Contact], [Supplier Reference],
         [Payment Days], [Postal Code], [Valid From], [Valid To], [Lineage Key])
    VALUES
        (0, 0, N'Unknown', N'N/A', N'N/A', N'N/A',
         0, N'N/A', @StartOfTime, @EndOfTime, 0);

    INSERT Dimension.[Transaction Type]
        ([Transaction Type Key], [WWI Transaction Type ID], [Transaction Type], [Valid From], [Valid To], [Lineage Key])
    VALUES
        (0, 0, N'Unknown', @StartOfTime, @EndOfTime, 0);
END;
GO
/****** Object:  StoredProcedure [Integration].[GetLastETLCutoffTime]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Integration].[GetLastETLCutoffTime]
@TableName sysname
WITH EXECUTE AS OWNER
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    SELECT [Cutoff Time] AS CutoffTime
    FROM Integration.[ETL Cutoff]
    WHERE [Table Name] = @TableName;

    IF @@ROWCOUNT = 0
    BEGIN
        PRINT N'Invalid ETL table name';
        THROW 51000, N'Invalid ETL table name', 1;
        RETURN -1;
    END;

    RETURN 0;
END;
GO
/****** Object:  StoredProcedure [Integration].[GetLineageKey]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Integration].[GetLineageKey]
@TableName sysname,
@NewCutoffTime datetime2(7)
WITH EXECUTE AS OWNER
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @DataLoadStartedWhen datetime2(7) = SYSDATETIME();

    INSERT Integration.Lineage
        ([Data Load Started], [Table Name], [Data Load Completed],
         [Was Successful], [Source System Cutoff Time])
    VALUES
        (@DataLoadStartedWhen, @TableName, NULL,
         0, @NewCutoffTime);

    SELECT TOP(1) [Lineage Key] AS LineageKey
    FROM Integration.Lineage
    WHERE [Table Name] = @TableName
    AND [Data Load Started] = @DataLoadStartedWhen
    ORDER BY LineageKey DESC;

    RETURN 0;
END;
GO
/****** Object:  StoredProcedure [Integration].[MigrateStagedCityData]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Integration].[MigrateStagedCityData]
WITH EXECUTE AS OWNER
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @EndOfTime datetime2(7) =  '99991231 23:59:59.9999999';

    BEGIN TRAN;

    DECLARE @LineageKey int = (SELECT TOP(1) [Lineage Key]
                               FROM Integration.Lineage
                               WHERE [Table Name] = N'City'
                               AND [Data Load Completed] IS NULL
                               ORDER BY [Lineage Key] DESC);

    WITH RowsToCloseOff
    AS
    (
        SELECT c.[WWI City ID], MIN(c.[Valid From]) AS [Valid From]
        FROM Integration.City_Staging AS c
        GROUP BY c.[WWI City ID]
    )
    UPDATE c
        SET c.[Valid To] = rtco.[Valid From]
    FROM Dimension.City AS c
    INNER JOIN RowsToCloseOff AS rtco
    ON c.[WWI City ID] = rtco.[WWI City ID]
    WHERE c.[Valid To] = @EndOfTime;

    INSERT Dimension.City
        ([WWI City ID], City, [State Province], Country, Continent,
         [Sales Territory], Region, Subregion, [Location],
         [Latest Recorded Population], [Valid From], [Valid To],
         [Lineage Key])
    SELECT [WWI City ID], City, [State Province], Country, Continent,
           [Sales Territory], Region, Subregion, [Location],
           [Latest Recorded Population], [Valid From], [Valid To],
           @LineageKey
    FROM Integration.City_Staging;

    UPDATE Integration.Lineage
        SET [Data Load Completed] = SYSDATETIME(),
            [Was Successful] = 1
    WHERE [Lineage Key] = @LineageKey;

    UPDATE Integration.[ETL Cutoff]
        SET [Cutoff Time] = (SELECT [Source System Cutoff Time]
                             FROM Integration.Lineage
                             WHERE [Lineage Key] = @LineageKey)
    FROM Integration.[ETL Cutoff]
    WHERE [Table Name] = N'City';

    COMMIT;

    RETURN 0;
END;
GO
/****** Object:  StoredProcedure [Integration].[MigrateStagedCustomerData]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Integration].[MigrateStagedCustomerData]
WITH EXECUTE AS OWNER
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @EndOfTime datetime2(7) =  '99991231 23:59:59.9999999';

    BEGIN TRAN;

    DECLARE @LineageKey int = (SELECT TOP(1) [Lineage Key]
                               FROM Integration.Lineage
                               WHERE [Table Name] = N'Customer'
                               AND [Data Load Completed] IS NULL
                               ORDER BY [Lineage Key] DESC);

    WITH RowsToCloseOff
    AS
    (
        SELECT c.[WWI Customer ID], MIN(c.[Valid From]) AS [Valid From]
        FROM Integration.Customer_Staging AS c
        GROUP BY c.[WWI Customer ID]
    )
    UPDATE c
        SET c.[Valid To] = rtco.[Valid From]
    FROM Dimension.Customer AS c
    INNER JOIN RowsToCloseOff AS rtco
    ON c.[WWI Customer ID] = rtco.[WWI Customer ID]
    WHERE c.[Valid To] = @EndOfTime;

    INSERT Dimension.Customer
        ([WWI Customer ID], Customer, [Bill To Customer], Category,
         [Buying Group], [Primary Contact], [Postal Code], [Valid From], [Valid To],
         [Lineage Key])
    SELECT [WWI Customer ID], Customer, [Bill To Customer], Category,
           [Buying Group], [Primary Contact], [Postal Code], [Valid From], [Valid To],
           @LineageKey
    FROM Integration.Customer_Staging;

    UPDATE Integration.Lineage
        SET [Data Load Completed] = SYSDATETIME(),
            [Was Successful] = 1
    WHERE [Lineage Key] = @LineageKey;

    UPDATE Integration.[ETL Cutoff]
        SET [Cutoff Time] = (SELECT [Source System Cutoff Time]
                             FROM Integration.Lineage
                             WHERE [Lineage Key] = @LineageKey)
    FROM Integration.[ETL Cutoff]
    WHERE [Table Name] = N'Customer';

    COMMIT;

    RETURN 0;
END;
GO
/****** Object:  StoredProcedure [Integration].[MigrateStagedEmployeeData]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Integration].[MigrateStagedEmployeeData]
WITH EXECUTE AS OWNER
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @EndOfTime datetime2(7) =  '99991231 23:59:59.9999999';

    BEGIN TRAN;

    DECLARE @LineageKey int = (SELECT TOP(1) [Lineage Key]
                               FROM Integration.Lineage
                               WHERE [Table Name] = N'Employee'
                               AND [Data Load Completed] IS NULL
                               ORDER BY [Lineage Key] DESC);

    WITH RowsToCloseOff
    AS
    (
        SELECT e.[WWI Employee ID], MIN(e.[Valid From]) AS [Valid From]
        FROM Integration.Employee_Staging AS e
        GROUP BY e.[WWI Employee ID]
    )
    UPDATE e
        SET e.[Valid To] = rtco.[Valid From]
    FROM Dimension.Employee AS e
    INNER JOIN RowsToCloseOff AS rtco
    ON e.[WWI Employee ID] = rtco.[WWI Employee ID]
    WHERE e.[Valid To] = @EndOfTime;

    INSERT Dimension.Employee
        ([WWI Employee ID], Employee, [Preferred Name], [Is Salesperson], Photo, [Valid From], [Valid To], [Lineage Key])
    SELECT [WWI Employee ID], Employee, [Preferred Name], [Is Salesperson], Photo, [Valid From], [Valid To],
           @LineageKey
    FROM Integration.Employee_Staging;

    UPDATE Integration.Lineage
        SET [Data Load Completed] = SYSDATETIME(),
            [Was Successful] = 1
    WHERE [Lineage Key] = @LineageKey;

    UPDATE Integration.[ETL Cutoff]
        SET [Cutoff Time] = (SELECT [Source System Cutoff Time]
                             FROM Integration.Lineage
                             WHERE [Lineage Key] = @LineageKey)
    FROM Integration.[ETL Cutoff]
    WHERE [Table Name] = N'Employee';

    COMMIT;

    RETURN 0;
END;
GO
/****** Object:  StoredProcedure [Integration].[MigrateStagedMovementData]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Integration].[MigrateStagedMovementData]
WITH EXECUTE AS OWNER
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRAN;

    DECLARE @LineageKey int = (SELECT TOP(1) [Lineage Key]
                               FROM Integration.Lineage
                               WHERE [Table Name] = N'Movement'
                               AND [Data Load Completed] IS NULL
                               ORDER BY [Lineage Key] DESC);

    -- Find the dimension keys required

    UPDATE m
        SET m.[Stock Item Key] = COALESCE((SELECT TOP(1) si.[Stock Item Key]
                                           FROM Dimension.[Stock Item] AS si
                                           WHERE si.[WWI Stock Item ID] = m.[WWI Stock Item ID]
                                           AND m.[Last Modifed When] > si.[Valid From]
                                           AND m.[Last Modifed When] <= si.[Valid To]
									       ORDER BY si.[Valid From]), 0),
            m.[Customer Key] = COALESCE((SELECT TOP(1) c.[Customer Key]
                                         FROM Dimension.Customer AS c
                                         WHERE c.[WWI Customer ID] = m.[WWI Customer ID]
                                         AND m.[Last Modifed When] > c.[Valid From]
                                         AND m.[Last Modifed When] <= c.[Valid To]
									     ORDER BY c.[Valid From]), 0),
            m.[Supplier Key] = COALESCE((SELECT TOP(1) s.[Supplier Key]
                                         FROM Dimension.Supplier AS s
                                         WHERE s.[WWI Supplier ID] = m.[WWI Supplier ID]
                                         AND m.[Last Modifed When] > s.[Valid From]
                                         AND m.[Last Modifed When] <= s.[Valid To]
									     ORDER BY s.[Valid From]), 0),
            m.[Transaction Type Key] = COALESCE((SELECT TOP(1) tt.[Transaction Type Key]
                                                 FROM Dimension.[Transaction Type] AS tt
                                                 WHERE tt.[WWI Transaction Type ID] = m.[WWI Transaction Type ID]
                                                 AND m.[Last Modifed When] > tt.[Valid From]
                                                 AND m.[Last Modifed When] <= tt.[Valid To]
									             ORDER BY tt.[Valid From]), 0)
    FROM Integration.Movement_Staging AS m;

    -- Merge the data into the fact table

    MERGE Fact.Movement AS m
    USING Integration.Movement_Staging AS ms
    ON m.[WWI Stock Item Transaction ID] = ms.[WWI Stock Item Transaction ID]
    WHEN MATCHED THEN
        UPDATE SET m.[Date Key] = ms.[Date Key],
                   m.[Stock Item Key] = ms.[Stock Item Key],
                   m.[Customer Key] = ms.[Customer Key],
                   m.[Supplier Key] = ms.[Supplier Key],
                   m.[Transaction Type Key] = ms.[Transaction Type Key],
                   m.[WWI Invoice ID] = ms.[WWI Invoice ID],
                   m.[WWI Purchase Order ID] = ms.[WWI Purchase Order ID],
                   m.Quantity = ms.Quantity,
                   m.[Lineage Key] = @LineageKey
    WHEN NOT MATCHED THEN
        INSERT ([Date Key], [Stock Item Key], [Customer Key], [Supplier Key], [Transaction Type Key],
                [WWI Stock Item Transaction ID], [WWI Invoice ID], [WWI Purchase Order ID], Quantity, [Lineage Key])
        VALUES (ms.[Date Key], ms.[Stock Item Key], ms.[Customer Key], ms.[Supplier Key], ms.[Transaction Type Key],
                ms.[WWI Stock Item Transaction ID], ms.[WWI Invoice ID], ms.[WWI Purchase Order ID], ms.Quantity, @LineageKey);

    UPDATE Integration.Lineage
        SET [Data Load Completed] = SYSDATETIME(),
            [Was Successful] = 1
    WHERE [Lineage Key] = @LineageKey;

    UPDATE Integration.[ETL Cutoff]
        SET [Cutoff Time] = (SELECT [Source System Cutoff Time]
                             FROM Integration.Lineage
                             WHERE [Lineage Key] = @LineageKey)
    FROM Integration.[ETL Cutoff]
    WHERE [Table Name] = N'Movement';

    COMMIT;

    RETURN 0;
END;
GO
/****** Object:  StoredProcedure [Integration].[MigrateStagedOrderData]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Integration].[MigrateStagedOrderData]
WITH EXECUTE AS OWNER
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRAN;

    DECLARE @LineageKey int = (SELECT TOP(1) [Lineage Key]
                               FROM Integration.Lineage
                               WHERE [Table Name] = N'Order'
                               AND [Data Load Completed] IS NULL
                               ORDER BY [Lineage Key] DESC);

    -- Find the dimension keys required

    UPDATE o
        SET o.[City Key] = COALESCE((SELECT TOP(1) c.[City Key]
                                     FROM Dimension.City AS c
                                     WHERE c.[WWI City ID] = o.[WWI City ID]
                                     AND o.[Last Modified When] > c.[Valid From]
                                     AND o.[Last Modified When] <= c.[Valid To]
									 ORDER BY c.[Valid From]), 0),
            o.[Customer Key] = COALESCE((SELECT TOP(1) c.[Customer Key]
                                         FROM Dimension.Customer AS c
                                         WHERE c.[WWI Customer ID] = o.[WWI Customer ID]
                                         AND o.[Last Modified When] > c.[Valid From]
                                         AND o.[Last Modified When] <= c.[Valid To]
    									 ORDER BY c.[Valid From]), 0),
            o.[Stock Item Key] = COALESCE((SELECT TOP(1) si.[Stock Item Key]
                                           FROM Dimension.[Stock Item] AS si
                                           WHERE si.[WWI Stock Item ID] = o.[WWI Stock Item ID]
                                           AND o.[Last Modified When] > si.[Valid From]
                                           AND o.[Last Modified When] <= si.[Valid To]
					                       ORDER BY si.[Valid From]), 0),
            o.[Salesperson Key] = COALESCE((SELECT TOP(1) e.[Employee Key]
                                         FROM Dimension.Employee AS e
                                         WHERE e.[WWI Employee ID] = o.[WWI Salesperson ID]
                                         AND o.[Last Modified When] > e.[Valid From]
                                         AND o.[Last Modified When] <= e.[Valid To]
									     ORDER BY e.[Valid From]), 0),
            o.[Picker Key] = COALESCE((SELECT TOP(1) e.[Employee Key]
                                       FROM Dimension.Employee AS e
                                       WHERE e.[WWI Employee ID] = o.[WWI Picker ID]
                                       AND o.[Last Modified When] > e.[Valid From]
                                       AND o.[Last Modified When] <= e.[Valid To]
									   ORDER BY e.[Valid From]), 0)
    FROM Integration.Order_Staging AS o;

    -- Remove any existing entries for any of these orders

    DELETE o
    FROM Fact.[Order] AS o
    WHERE o.[WWI Order ID] IN (SELECT [WWI Order ID] FROM Integration.Order_Staging);

    -- Insert all current details for these orders

    INSERT Fact.[Order]
        ([City Key], [Customer Key], [Stock Item Key], [Order Date Key], [Picked Date Key],
         [Salesperson Key], [Picker Key], [WWI Order ID], [WWI Backorder ID], [Description],
         Package, Quantity, [Unit Price], [Tax Rate], [Total Excluding Tax], [Tax Amount],
         [Total Including Tax], [Lineage Key])
    SELECT [City Key], [Customer Key], [Stock Item Key], [Order Date Key], [Picked Date Key],
           [Salesperson Key], [Picker Key], [WWI Order ID], [WWI Backorder ID], [Description],
           Package, Quantity, [Unit Price], [Tax Rate], [Total Excluding Tax], [Tax Amount],
           [Total Including Tax], @LineageKey
    FROM Integration.Order_Staging;

    UPDATE Integration.Lineage
        SET [Data Load Completed] = SYSDATETIME(),
            [Was Successful] = 1
    WHERE [Lineage Key] = @LineageKey;

    UPDATE Integration.[ETL Cutoff]
        SET [Cutoff Time] = (SELECT [Source System Cutoff Time]
                             FROM Integration.Lineage
                             WHERE [Lineage Key] = @LineageKey)
    FROM Integration.[ETL Cutoff]
    WHERE [Table Name] = N'Order';

    COMMIT;

    RETURN 0;
END;
GO
/****** Object:  StoredProcedure [Integration].[MigrateStagedPaymentMethodData]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Integration].[MigrateStagedPaymentMethodData]
WITH EXECUTE AS OWNER
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @EndOfTime datetime2(7) =  '99991231 23:59:59.9999999';

    BEGIN TRAN;

    DECLARE @LineageKey int = (SELECT TOP(1) [Lineage Key]
                               FROM Integration.Lineage
                               WHERE [Table Name] = N'Payment Method'
                               AND [Data Load Completed] IS NULL
                               ORDER BY [Lineage Key] DESC);

    WITH RowsToCloseOff
    AS
    (
        SELECT pm.[WWI Payment Method ID], MIN(pm.[Valid From]) AS [Valid From]
        FROM Integration.PaymentMethod_Staging AS pm
        GROUP BY pm.[WWI Payment Method ID]
    )
    UPDATE pm
        SET pm.[Valid To] = rtco.[Valid From]
    FROM Dimension.[Payment Method] AS pm
    INNER JOIN RowsToCloseOff AS rtco
    ON pm.[WWI Payment Method ID] = rtco.[WWI Payment Method ID]
    WHERE pm.[Valid To] = @EndOfTime;

    INSERT Dimension.[Payment Method]
        ([WWI Payment Method ID], [Payment Method], [Valid From], [Valid To], [Lineage Key])
    SELECT [WWI Payment Method ID], [Payment Method], [Valid From], [Valid To],
           @LineageKey
    FROM Integration.PaymentMethod_Staging;

    UPDATE Integration.Lineage
        SET [Data Load Completed] = SYSDATETIME(),
            [Was Successful] = 1
    WHERE [Lineage Key] = @LineageKey;

    UPDATE Integration.[ETL Cutoff]
        SET [Cutoff Time] = (SELECT [Source System Cutoff Time]
                             FROM Integration.Lineage
                             WHERE [Lineage Key] = @LineageKey)
    FROM Integration.[ETL Cutoff]
    WHERE [Table Name] = N'Payment Method';

    COMMIT;

    RETURN 0;
END;
GO
/****** Object:  StoredProcedure [Integration].[MigrateStagedPurchaseData]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Integration].[MigrateStagedPurchaseData]
WITH EXECUTE AS OWNER
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRAN;

    DECLARE @LineageKey int = (SELECT TOP(1) [Lineage Key]
                               FROM Integration.Lineage
                               WHERE [Table Name] = N'Purchase'
                               AND [Data Load Completed] IS NULL
                               ORDER BY [Lineage Key] DESC);

    -- Find the dimension keys required

    UPDATE p
        SET p.[Supplier Key] = COALESCE((SELECT TOP(1) s.[Supplier Key]
                                     FROM Dimension.Supplier AS s
                                     WHERE s.[WWI Supplier ID] = p.[WWI Supplier ID]
                                     AND p.[Last Modified When] > s.[Valid From]
                                     AND p.[Last Modified When] <= s.[Valid To]
									 ORDER BY s.[Valid From]), 0),
            p.[Stock Item Key] = COALESCE((SELECT TOP(1) si.[Stock Item Key]
                                           FROM Dimension.[Stock Item] AS si
                                           WHERE si.[WWI Stock Item ID] = p.[WWI Stock Item ID]
                                           AND p.[Last Modified When] > si.[Valid From]
                                           AND p.[Last Modified When] <= si.[Valid To]
									       ORDER BY si.[Valid From]), 0)
    FROM Integration.Purchase_Staging AS p;

    -- Remove any existing entries for any of these purchase orders

    DELETE p
    FROM Fact.Purchase AS p
    WHERE p.[WWI Purchase Order ID] IN (SELECT [WWI Purchase Order ID] FROM Integration.Purchase_Staging);

    -- Insert all current details for these purchase orders

    INSERT Fact.Purchase
        ([Date Key], [Supplier Key], [Stock Item Key], [WWI Purchase Order ID], [Ordered Outers], [Ordered Quantity],
         [Received Outers], Package, [Is Order Finalized], [Lineage Key])
    SELECT [Date Key], [Supplier Key], [Stock Item Key], [WWI Purchase Order ID], [Ordered Outers], [Ordered Quantity],
           [Received Outers], Package, [Is Order Finalized], @LineageKey
    FROM Integration.Purchase_Staging;

    UPDATE Integration.Lineage
        SET [Data Load Completed] = SYSDATETIME(),
            [Was Successful] = 1
    WHERE [Lineage Key] = @LineageKey;

    UPDATE Integration.[ETL Cutoff]
        SET [Cutoff Time] = (SELECT [Source System Cutoff Time]
                             FROM Integration.Lineage
                             WHERE [Lineage Key] = @LineageKey)
    FROM Integration.[ETL Cutoff]
    WHERE [Table Name] = N'Purchase';

    COMMIT;

    RETURN 0;
END;
GO
/****** Object:  StoredProcedure [Integration].[MigrateStagedSaleData]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Integration].[MigrateStagedSaleData]
WITH EXECUTE AS OWNER
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRAN;

    DECLARE @LineageKey int = (SELECT TOP(1) [Lineage Key]
                               FROM Integration.Lineage
                               WHERE [Table Name] = N'Sale'
                               AND [Data Load Completed] IS NULL
                               ORDER BY [Lineage Key] DESC);

    -- Find the dimension keys required

    UPDATE s
        SET s.[City Key] = COALESCE((SELECT TOP(1) c.[City Key]
                                     FROM Dimension.City AS c
                                     WHERE c.[WWI City ID] = s.[WWI City ID]
                                     AND s.[Last Modified When] > c.[Valid From]
                                     AND s.[Last Modified When] <= c.[Valid To]
									 ORDER BY c.[Valid From]), 0),
            s.[Customer Key] = COALESCE((SELECT TOP(1) c.[Customer Key]
                                           FROM Dimension.Customer AS c
                                           WHERE c.[WWI Customer ID] = s.[WWI Customer ID]
                                           AND s.[Last Modified When] > c.[Valid From]
                                           AND s.[Last Modified When] <= c.[Valid To]
									       ORDER BY c.[Valid From]), 0),
            s.[Bill To Customer Key] = COALESCE((SELECT TOP(1) c.[Customer Key]
                                                 FROM Dimension.Customer AS c
                                                 WHERE c.[WWI Customer ID] = s.[WWI Bill To Customer ID]
                                                 AND s.[Last Modified When] > c.[Valid From]
                                                 AND s.[Last Modified When] <= c.[Valid To]
									             ORDER BY c.[Valid From]), 0),
            s.[Stock Item Key] = COALESCE((SELECT TOP(1) si.[Stock Item Key]
                                           FROM Dimension.[Stock Item] AS si
                                           WHERE si.[WWI Stock Item ID] = s.[WWI Stock Item ID]
                                           AND s.[Last Modified When] > si.[Valid From]
                                           AND s.[Last Modified When] <= si.[Valid To]
									       ORDER BY si.[Valid From]), 0),
            s.[Salesperson Key] = COALESCE((SELECT TOP(1) e.[Employee Key]
                                            FROM Dimension.Employee AS e
                                            WHERE e.[WWI Employee ID] = s.[WWI Salesperson ID]
                                            AND s.[Last Modified When] > e.[Valid From]
                                            AND s.[Last Modified When] <= e.[Valid To]
									        ORDER BY e.[Valid From]), 0)
    FROM Integration.Sale_Staging AS s;

    -- Remove any existing entries for any of these invoices

    DELETE s
    FROM Fact.Sale AS s
    WHERE s.[WWI Invoice ID] IN (SELECT [WWI Invoice ID] FROM Integration.Sale_Staging);

    -- Insert all current details for these invoices

    INSERT Fact.Sale
        ([City Key], [Customer Key], [Bill To Customer Key], [Stock Item Key], [Invoice Date Key], [Delivery Date Key],
         [Salesperson Key], [WWI Invoice ID], [Description], Package, Quantity, [Unit Price], [Tax Rate],
         [Total Excluding Tax], [Tax Amount], Profit, [Total Including Tax], [Total Dry Items], [Total Chiller Items], [Lineage Key])
    SELECT [City Key], [Customer Key], [Bill To Customer Key], [Stock Item Key], [Invoice Date Key], [Delivery Date Key],
           [Salesperson Key], [WWI Invoice ID], [Description], Package, Quantity, [Unit Price], [Tax Rate],
           [Total Excluding Tax], [Tax Amount], Profit, [Total Including Tax], [Total Dry Items], [Total Chiller Items], @LineageKey
    FROM Integration.Sale_Staging;

    UPDATE Integration.Lineage
        SET [Data Load Completed] = SYSDATETIME(),
            [Was Successful] = 1
    WHERE [Lineage Key] = @LineageKey;

    UPDATE Integration.[ETL Cutoff]
        SET [Cutoff Time] = (SELECT [Source System Cutoff Time]
                             FROM Integration.Lineage
                             WHERE [Lineage Key] = @LineageKey)
    FROM Integration.[ETL Cutoff]
    WHERE [Table Name] = N'Sale';

    COMMIT;

    RETURN 0;
END;
GO
/****** Object:  StoredProcedure [Integration].[MigrateStagedStockHoldingData]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Integration].[MigrateStagedStockHoldingData]
WITH EXECUTE AS OWNER
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRAN;

    DECLARE @LineageKey int = (SELECT TOP(1) [Lineage Key]
                               FROM Integration.Lineage
                               WHERE [Table Name] = N'Stock Holding'
                               AND [Data Load Completed] IS NULL
                               ORDER BY [Lineage Key] DESC);

    -- Find the dimension keys required

    UPDATE s
        SET s.[Stock Item Key] = COALESCE((SELECT TOP(1) si.[Stock Item Key]
                                           FROM Dimension.[Stock Item] AS si
                                           WHERE si.[WWI Stock Item ID] = s.[WWI Stock Item ID]
                                           ORDER BY si.[Valid To] DESC), 0)
    FROM Integration.StockHolding_Staging AS s;

    -- Remove all existing holdings

    TRUNCATE TABLE Fact.[Stock Holding];

    -- Insert all current stock holdings

    INSERT Fact.[Stock Holding]
        ([Stock Item Key], [Quantity On Hand], [Bin Location], [Last Stocktake Quantity],
         [Last Cost Price], [Reorder Level], [Target Stock Level], [Lineage Key])
    SELECT [Stock Item Key], [Quantity On Hand], [Bin Location], [Last Stocktake Quantity],
           [Last Cost Price], [Reorder Level], [Target Stock Level], @LineageKey
    FROM Integration.StockHolding_Staging;

    UPDATE Integration.Lineage
        SET [Data Load Completed] = SYSDATETIME(),
            [Was Successful] = 1
    WHERE [Lineage Key] = @LineageKey;

    UPDATE Integration.[ETL Cutoff]
        SET [Cutoff Time] = (SELECT [Source System Cutoff Time]
                             FROM Integration.Lineage
                             WHERE [Lineage Key] = @LineageKey)
    FROM Integration.[ETL Cutoff]
    WHERE [Table Name] = N'Stock Holding';

    COMMIT;

    RETURN 0;
END;
GO
/****** Object:  StoredProcedure [Integration].[MigrateStagedStockItemData]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Integration].[MigrateStagedStockItemData]
WITH EXECUTE AS OWNER
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @EndOfTime datetime2(7) =  '99991231 23:59:59.9999999';

    BEGIN TRAN;

    DECLARE @LineageKey int = (SELECT TOP(1) [Lineage Key]
                               FROM Integration.Lineage
                               WHERE [Table Name] = N'Stock Item'
                               AND [Data Load Completed] IS NULL
                               ORDER BY [Lineage Key] DESC);

    WITH RowsToCloseOff
    AS
    (
        SELECT s.[WWI Stock Item ID], MIN(s.[Valid From]) AS [Valid From]
        FROM Integration.StockItem_Staging AS s
        GROUP BY s.[WWI Stock Item ID]
    )
    UPDATE s
        SET s.[Valid To] = rtco.[Valid From]
    FROM Dimension.[Stock Item] AS s
    INNER JOIN RowsToCloseOff AS rtco
    ON s.[WWI Stock Item ID] = rtco.[WWI Stock Item ID]
    WHERE s.[Valid To] = @EndOfTime;

    INSERT Dimension.[Stock Item]
        ([WWI Stock Item ID], [Stock Item], Color, [Selling Package], [Buying Package],
         Brand, Size, [Lead Time Days], [Quantity Per Outer], [Is Chiller Stock],
         Barcode, [Tax Rate], [Unit Price], [Recommended Retail Price], [Typical Weight Per Unit],
         Photo, [Valid From], [Valid To], [Lineage Key])
    SELECT [WWI Stock Item ID], [Stock Item], Color, [Selling Package], [Buying Package],
           Brand, Size, [Lead Time Days], [Quantity Per Outer], [Is Chiller Stock],
           Barcode, [Tax Rate], [Unit Price], [Recommended Retail Price], [Typical Weight Per Unit],
           Photo, [Valid From], [Valid To],
           @LineageKey
    FROM Integration.StockItem_Staging;

    UPDATE Integration.Lineage
        SET [Data Load Completed] = SYSDATETIME(),
            [Was Successful] = 1
    WHERE [Lineage Key] = @LineageKey;

    UPDATE Integration.[ETL Cutoff]
        SET [Cutoff Time] = (SELECT [Source System Cutoff Time]
                             FROM Integration.Lineage
                             WHERE [Lineage Key] = @LineageKey)
    FROM Integration.[ETL Cutoff]
    WHERE [Table Name] = N'Stock Item';

    COMMIT;

    RETURN 0;
END;
GO
/****** Object:  StoredProcedure [Integration].[MigrateStagedSupplierData]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Integration].[MigrateStagedSupplierData]
WITH EXECUTE AS OWNER
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @EndOfTime datetime2(7) =  '99991231 23:59:59.9999999';

    BEGIN TRAN;

    DECLARE @LineageKey int = (SELECT TOP(1) [Lineage Key]
                               FROM Integration.Lineage
                               WHERE [Table Name] = N'Supplier'
                               AND [Data Load Completed] IS NULL
                               ORDER BY [Lineage Key] DESC);

    WITH RowsToCloseOff
    AS
    (
        SELECT s.[WWI Supplier ID], MIN(s.[Valid From]) AS [Valid From]
        FROM Integration.Supplier_Staging AS s
        GROUP BY s.[WWI Supplier ID]
    )
    UPDATE s
        SET s.[Valid To] = rtco.[Valid From]
    FROM Dimension.[Supplier] AS s
    INNER JOIN RowsToCloseOff AS rtco
    ON s.[WWI Supplier ID] = rtco.[WWI Supplier ID]
    WHERE s.[Valid To] = @EndOfTime;

    INSERT Dimension.[Supplier]
        ([WWI Supplier ID], Supplier, Category, [Primary Contact], [Supplier Reference],
         [Payment Days], [Postal Code], [Valid From], [Valid To], [Lineage Key])
    SELECT [WWI Supplier ID], Supplier, Category, [Primary Contact], [Supplier Reference],
           [Payment Days], [Postal Code], [Valid From], [Valid To],
           @LineageKey
    FROM Integration.Supplier_Staging;

    UPDATE Integration.Lineage
        SET [Data Load Completed] = SYSDATETIME(),
            [Was Successful] = 1
    WHERE [Lineage Key] = @LineageKey;

    UPDATE Integration.[ETL Cutoff]
        SET [Cutoff Time] = (SELECT [Source System Cutoff Time]
                             FROM Integration.Lineage
                             WHERE [Lineage Key] = @LineageKey)
    FROM Integration.[ETL Cutoff]
    WHERE [Table Name] = N'Supplier';

    COMMIT;

    RETURN 0;
END;
GO
/****** Object:  StoredProcedure [Integration].[MigrateStagedTransactionData]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Integration].[MigrateStagedTransactionData]
WITH EXECUTE AS OWNER
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRAN;

    DECLARE @LineageKey int = (SELECT TOP(1) [Lineage Key]
                               FROM Integration.Lineage
                               WHERE [Table Name] = N'Transaction'
                               AND [Data Load Completed] IS NULL
                               ORDER BY [Lineage Key] DESC);

    -- Find the dimension keys required

    UPDATE t
        SET t.[Customer Key] = COALESCE((SELECT TOP(1) c.[Customer Key]
                                         FROM Dimension.Customer AS c
                                         WHERE c.[WWI Customer ID] = t.[WWI Customer ID]
                                         AND t.[Last Modified When] > c.[Valid From]
                                         AND t.[Last Modified When] <= c.[Valid To]
									     ORDER BY c.[Valid From]), 0),
            t.[Bill To Customer Key] = COALESCE((SELECT TOP(1) c.[Customer Key]
                                                 FROM Dimension.Customer AS c
                                                 WHERE c.[WWI Customer ID] = t.[WWI Bill To Customer ID]
                                                 AND t.[Last Modified When] > c.[Valid From]
                                                 AND t.[Last Modified When] <= c.[Valid To]
									             ORDER BY c.[Valid From]), 0),
            t.[Supplier Key] = COALESCE((SELECT TOP(1) s.[Supplier Key]
                                         FROM Dimension.Supplier AS s
                                         WHERE s.[WWI Supplier ID] = t.[WWI Supplier ID]
                                         AND t.[Last Modified When] > s.[Valid From]
                                         AND t.[Last Modified When] <= s.[Valid To]
									     ORDER BY s.[Valid From]), 0),
            t.[Transaction Type Key] = COALESCE((SELECT TOP(1) tt.[Transaction Type Key]
                                                 FROM Dimension.[Transaction Type] AS tt
                                                 WHERE tt.[WWI Transaction Type ID] = t.[WWI Transaction Type ID]
                                                 AND t.[Last Modified When] > tt.[Valid From]
                                                 AND t.[Last Modified When] <= tt.[Valid To]
									             ORDER BY tt.[Valid From]), 0),
            t.[Payment Method Key] = COALESCE((SELECT TOP(1) pm.[Payment Method Key]
                                                 FROM Dimension.[Payment Method] AS pm
                                                 WHERE pm.[WWI Payment Method ID] = t.[WWI Payment Method ID]
                                                 AND t.[Last Modified When] > pm.[Valid From]
                                                 AND t.[Last Modified When] <= pm.[Valid To]
									             ORDER BY pm.[Valid From]), 0)
    FROM Integration.Transaction_Staging AS t;

    -- Insert all the transactions

    INSERT Fact.[Transaction]
        ([Date Key], [Customer Key], [Bill To Customer Key], [Supplier Key], [Transaction Type Key],
         [Payment Method Key], [WWI Customer Transaction ID], [WWI Supplier Transaction ID],
         [WWI Invoice ID], [WWI Purchase Order ID], [Supplier Invoice Number], [Total Excluding Tax],
         [Tax Amount], [Total Including Tax], [Outstanding Balance], [Is Finalized], [Lineage Key])
    SELECT [Date Key], [Customer Key], [Bill To Customer Key], [Supplier Key], [Transaction Type Key],
         [Payment Method Key], [WWI Customer Transaction ID], [WWI Supplier Transaction ID],
         [WWI Invoice ID], [WWI Purchase Order ID], [Supplier Invoice Number], [Total Excluding Tax],
         [Tax Amount], [Total Including Tax], [Outstanding Balance], [Is Finalized], @LineageKey
    FROM Integration.Transaction_Staging;

    UPDATE Integration.Lineage
        SET [Data Load Completed] = SYSDATETIME(),
            [Was Successful] = 1
    WHERE [Lineage Key] = @LineageKey;

    UPDATE Integration.[ETL Cutoff]
        SET [Cutoff Time] = (SELECT [Source System Cutoff Time]
                             FROM Integration.Lineage
                             WHERE [Lineage Key] = @LineageKey)
    FROM Integration.[ETL Cutoff]
    WHERE [Table Name] = N'Transaction';

    COMMIT;

    RETURN 0;
END;
GO
/****** Object:  StoredProcedure [Integration].[MigrateStagedTransactionTypeData]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Integration].[MigrateStagedTransactionTypeData]
WITH EXECUTE AS OWNER
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @EndOfTime datetime2(7) =  '99991231 23:59:59.9999999';

    BEGIN TRAN;

    DECLARE @LineageKey int = (SELECT TOP(1) [Lineage Key]
                               FROM Integration.Lineage
                               WHERE [Table Name] = N'Transaction Type'
                               AND [Data Load Completed] IS NULL
                               ORDER BY [Lineage Key] DESC);

    WITH RowsToCloseOff
    AS
    (
        SELECT pm.[WWI Transaction Type ID], MIN(pm.[Valid From]) AS [Valid From]
        FROM Integration.TransactionType_Staging AS pm
        GROUP BY pm.[WWI Transaction Type ID]
    )
    UPDATE pm
        SET pm.[Valid To] = rtco.[Valid From]
    FROM Dimension.[Transaction Type] AS pm
    INNER JOIN RowsToCloseOff AS rtco
    ON pm.[WWI Transaction Type ID] = rtco.[WWI Transaction Type ID]
    WHERE pm.[Valid To] = @EndOfTime;

    INSERT Dimension.[Transaction Type]
        ([WWI Transaction Type ID], [Transaction Type], [Valid From], [Valid To], [Lineage Key])
    SELECT [WWI Transaction Type ID], [Transaction Type], [Valid From], [Valid To],
           @LineageKey
    FROM Integration.TransactionType_Staging;

    UPDATE Integration.Lineage
        SET [Data Load Completed] = SYSDATETIME(),
            [Was Successful] = 1
    WHERE [Lineage Key] = @LineageKey;

    UPDATE Integration.[ETL Cutoff]
        SET [Cutoff Time] = (SELECT [Source System Cutoff Time]
                             FROM Integration.Lineage
                             WHERE [Lineage Key] = @LineageKey)
    FROM Integration.[ETL Cutoff]
    WHERE [Table Name] = N'Transaction Type';

    COMMIT;

    RETURN 0;
END;
GO
/****** Object:  StoredProcedure [Integration].[PopulateDateDimensionForYear]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Integration].[PopulateDateDimensionForYear]
@YearNumber int
WITH EXECUTE AS OWNER
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @DateCounter date = DATEFROMPARTS(@YearNumber, 1, 1);

    BEGIN TRY;

        BEGIN TRAN;

        WHILE YEAR(@DateCounter) = @YearNumber
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM Dimension.[Date] WHERE [Date] = @DateCounter)
            BEGIN
                INSERT Dimension.[Date]
                    ([Date], [Day Number], [Day], [Month], [Short Month],
                     [Calendar Month Number], [Calendar Month Label], [Calendar Year], [Calendar Year Label],
                     [Fiscal Month Number], [Fiscal Month Label], [Fiscal Year], [Fiscal Year Label],
                     [ISO Week Number])
                SELECT [Date], [Day Number], [Day], [Month], [Short Month],
                       [Calendar Month Number], [Calendar Month Label], [Calendar Year], [Calendar Year Label],
                       [Fiscal Month Number], [Fiscal Month Label], [Fiscal Year], [Fiscal Year Label],
                       [ISO Week Number]
                FROM Integration.GenerateDateDimensionColumns(@DateCounter);
            END;
            SET @DateCounter = DATEADD(day, 1, @DateCounter);
        END;

        COMMIT;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0 ROLLBACK;
        PRINT N'Unable to populate dates for the year';
        THROW;
        RETURN -1;
    END CATCH;

    RETURN 0;
END;
GO
/****** Object:  StoredProcedure [Sequences].[ReseedAllSequences]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [Sequences].[ReseedAllSequences]
AS BEGIN
    -- Ensures that the next sequence values are above the maximum value of the related table columns
    SET NOCOUNT ON;
 
    EXEC Sequences.ReseedSequenceBeyondTableValues @SequenceName = 'CityKey', @SchemaName = 'Dimension', @TableName = 'City', @ColumnName = 'City Key';
    EXEC Sequences.ReseedSequenceBeyondTableValues @SequenceName = 'CustomerKey', @SchemaName = 'Dimension', @TableName = 'Customer', @ColumnName = 'Customer Key';
    EXEC Sequences.ReseedSequenceBeyondTableValues @SequenceName = 'EmployeeKey', @SchemaName = 'Dimension', @TableName = 'Employee', @ColumnName = 'Employee Key';
    EXEC Sequences.ReseedSequenceBeyondTableValues @SequenceName = 'LineageKey', @SchemaName = 'Integration', @TableName = 'Lineage', @ColumnName = 'Lineage Key';
    EXEC Sequences.ReseedSequenceBeyondTableValues @SequenceName = 'PaymentMethodKey', @SchemaName = 'Dimension', @TableName = 'Payment Method', @ColumnName = 'Payment Method Key';
    EXEC Sequences.ReseedSequenceBeyondTableValues @SequenceName = 'StockItemKey', @SchemaName = 'Dimension', @TableName = 'Stock Item', @ColumnName = 'Stock Item Key';
    EXEC Sequences.ReseedSequenceBeyondTableValues @SequenceName = 'SupplierKey', @SchemaName = 'Dimension', @TableName = 'Supplier', @ColumnName = 'Supplier Key';
    EXEC Sequences.ReseedSequenceBeyondTableValues @SequenceName = 'TransactionTypeKey', @SchemaName = 'Dimension', @TableName = 'Transaction Type', @ColumnName = 'Transaction Type Key';
END;
GO
/****** Object:  StoredProcedure [Sequences].[ReseedSequenceBeyondTableValues]    Script Date: 2024/05/01 18:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [Sequences].[ReseedSequenceBeyondTableValues]
@SequenceName sysname,
@SchemaName sysname,
@TableName sysname,
@ColumnName sysname
AS BEGIN
    -- Ensures that the next sequence value is above the maximum value of the supplied table column
    SET NOCOUNT ON;
 
    DECLARE @SQL nvarchar(max);
    DECLARE @CurrentTableMaximumValue bigint;
    DECLARE @NewSequenceValue bigint;
    DECLARE @CurrentSequenceMaximumValue bigint
        = (SELECT CAST(current_value AS bigint) FROM sys.sequences
                                                WHERE name = @SequenceName
                                                AND SCHEMA_NAME(schema_id) = N'Sequences');
    CREATE TABLE #CurrentValue
    (
        CurrentValue bigint
    )
 
    SET @SQL = N'INSERT #CurrentValue (CurrentValue) SELECT COALESCE(MAX(' + QUOTENAME(@ColumnName) + N'), 0) FROM ' + QUOTENAME(@SchemaName) + N'.' + QUOTENAME(@TableName) + N';';
    EXECUTE (@SQL);
    SET @CurrentTableMaximumValue = (SELECT CurrentValue FROM #CurrentValue);
    DROP TABLE #CurrentValue;
 
    IF @CurrentTableMaximumValue >= @CurrentSequenceMaximumValue
    BEGIN
        SET @NewSequenceValue = @CurrentTableMaximumValue + 1;
        SET @SQL = N'ALTER SEQUENCE Sequences.' + QUOTENAME(@SequenceName) + N' RESTART WITH ' + CAST(@NewSequenceValue AS nvarchar(20)) + N';';
        EXECUTE (@SQL);
    END;
END;
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Application configuration code' , @level0type=N'SCHEMA',@level0name=N'Application'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Dimensional model dimension tables' , @level0type=N'SCHEMA',@level0name=N'Dimension'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Dimensional model fact tables' , @level0type=N'SCHEMA',@level0name=N'Fact'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Objects needed for ETL integration' , @level0type=N'SCHEMA',@level0name=N'Integration'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Views and stored procedures that provide the only access for the Power BI dashboard system' , @level0type=N'SCHEMA',@level0name=N'PowerBI'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Views and stored procedures that provide the only access for the reporting system' , @level0type=N'SCHEMA',@level0name=N'Reports'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Holds sequences used by all tables in the application' , @level0type=N'SCHEMA',@level0name=N'Sequences'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Views and stored procedures that provide the only access for the application website' , @level0type=N'SCHEMA',@level0name=N'Website'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'DW key for the city dimension' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'City', @level2type=N'COLUMN',@level2name=N'City Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Numeric ID used for reference to a city within the WWI database' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'City', @level2type=N'COLUMN',@level2name=N'WWI City ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Formal name of the city' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'City', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'State or province for this city' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'City', @level2type=N'COLUMN',@level2name=N'State Province'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Country name' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'City', @level2type=N'COLUMN',@level2name=N'Country'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Continent that this city is on' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'City', @level2type=N'COLUMN',@level2name=N'Continent'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Sales territory for this StateProvince' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'City', @level2type=N'COLUMN',@level2name=N'Sales Territory'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Name of the region' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'City', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Name of the subregion' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'City', @level2type=N'COLUMN',@level2name=N'Subregion'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Geographic location of the city' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'City', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Latest available population for the City' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'City', @level2type=N'COLUMN',@level2name=N'Latest Recorded Population'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Valid from this date and time' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'City', @level2type=N'COLUMN',@level2name=N'Valid From'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Valid until this date and time' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'City', @level2type=N'COLUMN',@level2name=N'Valid To'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Lineage Key for the data load for this row' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'City', @level2type=N'COLUMN',@level2name=N'Lineage Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Allows quickly locating by WWI ID' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'City', @level2type=N'INDEX',@level2name=N'IX_Dimension_City_WWICityID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'City dimension' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'DW key for the customer dimension' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Customer Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Numeric ID used for reference to a customer within the WWI database' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'WWI Customer ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Customer''s full name (usually a trading name)' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Customer'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Bill to customer''s full name' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Bill To Customer'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Customer''s category' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Category'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Customer''s buying group' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Buying Group'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Primary contact' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Primary Contact'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Delivery postal code for the customer' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Postal Code'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Valid from this date and time' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Valid From'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Valid until this date and time' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Valid To'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Lineage Key for the data load for this row' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'Lineage Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Allows quickly locating by WWI ID' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'INDEX',@level2name=N'IX_Dimension_Customer_WWICustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Customer dimension' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Customer'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'DW key for date dimension (actual date is used for key)' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Date', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Day of the month' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Date', @level2type=N'COLUMN',@level2name=N'Day Number'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Day name' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Date', @level2type=N'COLUMN',@level2name=N'Day'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Month name (ie September)' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Date', @level2type=N'COLUMN',@level2name=N'Month'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Short month name (ie Sep)' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Date', @level2type=N'COLUMN',@level2name=N'Short Month'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Calendar month number' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Date', @level2type=N'COLUMN',@level2name=N'Calendar Month Number'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Calendar month label (ie CY2015Jun)' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Date', @level2type=N'COLUMN',@level2name=N'Calendar Month Label'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Calendar year (ie 2015)' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Date', @level2type=N'COLUMN',@level2name=N'Calendar Year'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Calendar year label (ie CY2015)' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Date', @level2type=N'COLUMN',@level2name=N'Calendar Year Label'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Fiscal month number' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Date', @level2type=N'COLUMN',@level2name=N'Fiscal Month Number'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Fiscal month label (ie FY2015Feb)' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Date', @level2type=N'COLUMN',@level2name=N'Fiscal Month Label'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Fiscal year (ie 2016)' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Date', @level2type=N'COLUMN',@level2name=N'Fiscal Year'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Fiscal year label (ie FY2015)' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Date', @level2type=N'COLUMN',@level2name=N'Fiscal Year Label'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'ISO week number (ie 25)' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Date', @level2type=N'COLUMN',@level2name=N'ISO Week Number'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Date dimension' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'DW key for the employee dimension' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Employee Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Numeric ID (PersonID) in the WWI database' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'WWI Employee ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Full name for this person' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Employee'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Name that this person prefers to be called' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Preferred Name'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Is this person a staff salesperson?' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Is Salesperson'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Photo of this person' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Photo'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Valid from this date and time' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Valid From'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Valid until this date and time' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Valid To'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Lineage Key for the data load for this row' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Lineage Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Allows quickly locating by WWI ID' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'INDEX',@level2name=N'IX_Dimension_Employee_WWIEmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Employee dimension' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Employee'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'DW key for the payment method dimension' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Payment Method', @level2type=N'COLUMN',@level2name=N'Payment Method Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Numeric ID for the payment method in the WWI database' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Payment Method', @level2type=N'COLUMN',@level2name=N'WWI Payment Method ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Payment method name' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Payment Method', @level2type=N'COLUMN',@level2name=N'Payment Method'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Valid from this date and time' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Payment Method', @level2type=N'COLUMN',@level2name=N'Valid From'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Valid until this date and time' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Payment Method', @level2type=N'COLUMN',@level2name=N'Valid To'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Lineage Key for the data load for this row' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Payment Method', @level2type=N'COLUMN',@level2name=N'Lineage Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Allows quickly locating by WWI ID' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Payment Method', @level2type=N'INDEX',@level2name=N'IX_Dimension_Payment_Method_WWIPaymentMethodID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'PaymentMethod dimension' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Payment Method'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'DW key for the stock item dimension' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Stock Item', @level2type=N'COLUMN',@level2name=N'Stock Item Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Numeric ID used for reference to a stock item within the WWI database' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Stock Item', @level2type=N'COLUMN',@level2name=N'WWI Stock Item ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Full name of a stock item (but not a full description)' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Stock Item', @level2type=N'COLUMN',@level2name=N'Stock Item'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Color (optional) for this stock item' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Stock Item', @level2type=N'COLUMN',@level2name=N'Color'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Usual package for selling units of this stock item' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Stock Item', @level2type=N'COLUMN',@level2name=N'Selling Package'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Usual package for selling outers of this stock item (ie cartons, boxes, etc.)' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Stock Item', @level2type=N'COLUMN',@level2name=N'Buying Package'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Brand for the stock item (if the item is branded)' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Stock Item', @level2type=N'COLUMN',@level2name=N'Brand'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Size of this item (eg: 100mm)' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Stock Item', @level2type=N'COLUMN',@level2name=N'Size'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Number of days typically taken from order to receipt of this stock item' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Stock Item', @level2type=N'COLUMN',@level2name=N'Lead Time Days'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Quantity of the stock item in an outer package' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Stock Item', @level2type=N'COLUMN',@level2name=N'Quantity Per Outer'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Does this stock item need to be in a chiller?' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Stock Item', @level2type=N'COLUMN',@level2name=N'Is Chiller Stock'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Barcode for this stock item' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Stock Item', @level2type=N'COLUMN',@level2name=N'Barcode'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Tax rate to be applied' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Stock Item', @level2type=N'COLUMN',@level2name=N'Tax Rate'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Selling price (ex-tax) for one unit of this product' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Stock Item', @level2type=N'COLUMN',@level2name=N'Unit Price'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Recommended retail price for this stock item' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Stock Item', @level2type=N'COLUMN',@level2name=N'Recommended Retail Price'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Typical weight for one unit of this product (packaged)' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Stock Item', @level2type=N'COLUMN',@level2name=N'Typical Weight Per Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Photo of the product' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Stock Item', @level2type=N'COLUMN',@level2name=N'Photo'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Valid from this date and time' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Stock Item', @level2type=N'COLUMN',@level2name=N'Valid From'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Valid until this date and time' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Stock Item', @level2type=N'COLUMN',@level2name=N'Valid To'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Lineage Key for the data load for this row' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Stock Item', @level2type=N'COLUMN',@level2name=N'Lineage Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Allows quickly locating by WWI ID' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Stock Item', @level2type=N'INDEX',@level2name=N'IX_Dimension_Stock_Item_WWIStockItemID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'StockItem dimension' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Stock Item'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'DW key for the supplier dimension' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Supplier', @level2type=N'COLUMN',@level2name=N'Supplier Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Numeric ID used for reference to a supplier within the WWI database' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Supplier', @level2type=N'COLUMN',@level2name=N'WWI Supplier ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Supplier''s full name (usually a trading name)' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Supplier', @level2type=N'COLUMN',@level2name=N'Supplier'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Supplier''s category' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Supplier', @level2type=N'COLUMN',@level2name=N'Category'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Primary contact' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Supplier', @level2type=N'COLUMN',@level2name=N'Primary Contact'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Supplier reference for our organization (might be our account number at the supplier)' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Supplier', @level2type=N'COLUMN',@level2name=N'Supplier Reference'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Number of days for payment of an invoice (ie payment terms)' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Supplier', @level2type=N'COLUMN',@level2name=N'Payment Days'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Delivery postal code for the supplier' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Supplier', @level2type=N'COLUMN',@level2name=N'Postal Code'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Valid from this date and time' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Supplier', @level2type=N'COLUMN',@level2name=N'Valid From'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Valid until this date and time' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Supplier', @level2type=N'COLUMN',@level2name=N'Valid To'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Lineage Key for the data load for this row' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Supplier', @level2type=N'COLUMN',@level2name=N'Lineage Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Allows quickly locating by WWI ID' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Supplier', @level2type=N'INDEX',@level2name=N'IX_Dimension_Supplier_WWISupplierID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Supplier dimension' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Supplier'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'DW key for the transaction type dimension' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Transaction Type', @level2type=N'COLUMN',@level2name=N'Transaction Type Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Numeric ID used for reference to a transaction type within the WWI database' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Transaction Type', @level2type=N'COLUMN',@level2name=N'WWI Transaction Type ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Full name of the transaction type' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Transaction Type', @level2type=N'COLUMN',@level2name=N'Transaction Type'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Valid from this date and time' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Transaction Type', @level2type=N'COLUMN',@level2name=N'Valid From'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Valid until this date and time' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Transaction Type', @level2type=N'COLUMN',@level2name=N'Valid To'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Lineage Key for the data load for this row' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Transaction Type', @level2type=N'COLUMN',@level2name=N'Lineage Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Allows quickly locating by WWI ID' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Transaction Type', @level2type=N'INDEX',@level2name=N'IX_Dimension_Transaction_Type_WWITransactionTypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'TransactionType dimension' , @level0type=N'SCHEMA',@level0name=N'Dimension', @level1type=N'TABLE',@level1name=N'Transaction Type'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'DW key for a row in the Movement fact' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Movement', @level2type=N'COLUMN',@level2name=N'Movement Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Transaction date' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Movement', @level2type=N'COLUMN',@level2name=N'Date Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Stock item for this purchase order' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Movement', @level2type=N'COLUMN',@level2name=N'Stock Item Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Customer (if applicable)' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Movement', @level2type=N'COLUMN',@level2name=N'Customer Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Supplier (if applicable)' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Movement', @level2type=N'COLUMN',@level2name=N'Supplier Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Type of transaction' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Movement', @level2type=N'COLUMN',@level2name=N'Transaction Type Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Stock item transaction ID in source system' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Movement', @level2type=N'COLUMN',@level2name=N'WWI Stock Item Transaction ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Invoice ID in source system' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Movement', @level2type=N'COLUMN',@level2name=N'WWI Invoice ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Purchase order ID in source system' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Movement', @level2type=N'COLUMN',@level2name=N'WWI Purchase Order ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Quantity of stock movement (positive is incoming stock, negative is outgoing)' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Movement', @level2type=N'COLUMN',@level2name=N'Quantity'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Lineage Key for the data load for this row' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Movement', @level2type=N'COLUMN',@level2name=N'Lineage Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Movement fact table (movements of stock items)' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Movement'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'DW key for a row in the Order fact' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Order', @level2type=N'COLUMN',@level2name=N'Order Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'City for this order' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Order', @level2type=N'COLUMN',@level2name=N'City Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Customer for this order' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Order', @level2type=N'COLUMN',@level2name=N'Customer Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Stock item for this order' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Order', @level2type=N'COLUMN',@level2name=N'Stock Item Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Order date for this order' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Order', @level2type=N'COLUMN',@level2name=N'Order Date Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Picked date for this order' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Order', @level2type=N'COLUMN',@level2name=N'Picked Date Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Salesperson for this order' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Order', @level2type=N'COLUMN',@level2name=N'Salesperson Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Picker for this order' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Order', @level2type=N'COLUMN',@level2name=N'Picker Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'OrderID in source system' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Order', @level2type=N'COLUMN',@level2name=N'WWI Order ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'BackorderID in source system' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Order', @level2type=N'COLUMN',@level2name=N'WWI Backorder ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Description of the item supplied (Usually the stock item name but can be overridden)' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Order', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Type of package to be supplied' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Order', @level2type=N'COLUMN',@level2name=N'Package'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Quantity to be supplied' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Order', @level2type=N'COLUMN',@level2name=N'Quantity'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Unit price to be charged' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Order', @level2type=N'COLUMN',@level2name=N'Unit Price'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Tax rate to be applied' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Order', @level2type=N'COLUMN',@level2name=N'Tax Rate'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Total amount excluding tax' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Order', @level2type=N'COLUMN',@level2name=N'Total Excluding Tax'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Total amount of tax' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Order', @level2type=N'COLUMN',@level2name=N'Tax Amount'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Total amount including tax' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Order', @level2type=N'COLUMN',@level2name=N'Total Including Tax'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Lineage Key for the data load for this row' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Order', @level2type=N'COLUMN',@level2name=N'Lineage Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Order fact table (customer orders)' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Order'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'DW key for a row in the Purchase fact' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Purchase', @level2type=N'COLUMN',@level2name=N'Purchase Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Purchase order date' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Purchase', @level2type=N'COLUMN',@level2name=N'Date Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Supplier for this purchase order' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Purchase', @level2type=N'COLUMN',@level2name=N'Supplier Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Stock item for this purchase order' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Purchase', @level2type=N'COLUMN',@level2name=N'Stock Item Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Purchase order ID in source system ' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Purchase', @level2type=N'COLUMN',@level2name=N'WWI Purchase Order ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Quantity of outers (ordering packages)' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Purchase', @level2type=N'COLUMN',@level2name=N'Ordered Outers'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Quantity of inners (selling packages)' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Purchase', @level2type=N'COLUMN',@level2name=N'Ordered Quantity'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Received outers (so far)' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Purchase', @level2type=N'COLUMN',@level2name=N'Received Outers'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Package ordered' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Purchase', @level2type=N'COLUMN',@level2name=N'Package'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Is this purchase order now finalized?' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Purchase', @level2type=N'COLUMN',@level2name=N'Is Order Finalized'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Lineage Key for the data load for this row' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Purchase', @level2type=N'COLUMN',@level2name=N'Lineage Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Purchase fact table (stock purchases from suppliers)' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Purchase'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'DW key for a row in the Sale fact' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Sale', @level2type=N'COLUMN',@level2name=N'Sale Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'City for this invoice' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Sale', @level2type=N'COLUMN',@level2name=N'City Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Customer for this invoice' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Sale', @level2type=N'COLUMN',@level2name=N'Customer Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Bill To Customer for this invoice' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Sale', @level2type=N'COLUMN',@level2name=N'Bill To Customer Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Stock item for this invoice' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Sale', @level2type=N'COLUMN',@level2name=N'Stock Item Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Invoice date for this invoice' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Sale', @level2type=N'COLUMN',@level2name=N'Invoice Date Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Date that these items were delivered' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Sale', @level2type=N'COLUMN',@level2name=N'Delivery Date Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Salesperson for this invoice' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Sale', @level2type=N'COLUMN',@level2name=N'Salesperson Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'InvoiceID in source system' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Sale', @level2type=N'COLUMN',@level2name=N'WWI Invoice ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Description of the item supplied (Usually the stock item name but can be overridden)' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Sale', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Type of package supplied' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Sale', @level2type=N'COLUMN',@level2name=N'Package'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Quantity supplied' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Sale', @level2type=N'COLUMN',@level2name=N'Quantity'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Unit price charged' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Sale', @level2type=N'COLUMN',@level2name=N'Unit Price'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Tax rate applied' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Sale', @level2type=N'COLUMN',@level2name=N'Tax Rate'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Total amount excluding tax' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Sale', @level2type=N'COLUMN',@level2name=N'Total Excluding Tax'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Total amount of tax' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Sale', @level2type=N'COLUMN',@level2name=N'Tax Amount'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Total amount of profit' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Sale', @level2type=N'COLUMN',@level2name=N'Profit'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Total amount including tax' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Sale', @level2type=N'COLUMN',@level2name=N'Total Including Tax'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Total number of dry items' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Sale', @level2type=N'COLUMN',@level2name=N'Total Dry Items'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Total number of chiller items' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Sale', @level2type=N'COLUMN',@level2name=N'Total Chiller Items'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Lineage Key for the data load for this row' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Sale', @level2type=N'COLUMN',@level2name=N'Lineage Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Sale fact table (invoiced sales to customers)' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Sale'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'DW key for a row in the Stock Holding fact' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Stock Holding', @level2type=N'COLUMN',@level2name=N'Stock Holding Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Stock item being held' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Stock Holding', @level2type=N'COLUMN',@level2name=N'Stock Item Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Quantity on hand' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Stock Holding', @level2type=N'COLUMN',@level2name=N'Quantity On Hand'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Bin location (where is this stock in the warehouse)' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Stock Holding', @level2type=N'COLUMN',@level2name=N'Bin Location'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Quantity present at last stocktake' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Stock Holding', @level2type=N'COLUMN',@level2name=N'Last Stocktake Quantity'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Unit cost when the stock item was last purchased' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Stock Holding', @level2type=N'COLUMN',@level2name=N'Last Cost Price'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Quantity below which reordering should take place' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Stock Holding', @level2type=N'COLUMN',@level2name=N'Reorder Level'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Typical stock level held' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Stock Holding', @level2type=N'COLUMN',@level2name=N'Target Stock Level'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Lineage Key for the data load for this row' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Stock Holding', @level2type=N'COLUMN',@level2name=N'Lineage Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Auto-created to support a foreign key' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Stock Holding', @level2type=N'INDEX',@level2name=N'FK_Fact_Stock_Holding_Stock_Item_Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Holdings of stock items' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Stock Holding'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'DW key for a row in the Transaction fact' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Transaction', @level2type=N'COLUMN',@level2name=N'Transaction Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Transaction date' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Transaction', @level2type=N'COLUMN',@level2name=N'Date Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Customer (if applicable)' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Transaction', @level2type=N'COLUMN',@level2name=N'Customer Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Bill to customer (if applicable)' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Transaction', @level2type=N'COLUMN',@level2name=N'Bill To Customer Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Supplier (if applicable)' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Transaction', @level2type=N'COLUMN',@level2name=N'Supplier Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Type of transaction' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Transaction', @level2type=N'COLUMN',@level2name=N'Transaction Type Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Payment method (if applicable)' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Transaction', @level2type=N'COLUMN',@level2name=N'Payment Method Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Customer transaction ID in source system' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Transaction', @level2type=N'COLUMN',@level2name=N'WWI Customer Transaction ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Supplier transaction ID in source system' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Transaction', @level2type=N'COLUMN',@level2name=N'WWI Supplier Transaction ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Invoice ID in source system' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Transaction', @level2type=N'COLUMN',@level2name=N'WWI Invoice ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Purchase order ID in source system' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Transaction', @level2type=N'COLUMN',@level2name=N'WWI Purchase Order ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Supplier invoice number (if applicable)' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Transaction', @level2type=N'COLUMN',@level2name=N'Supplier Invoice Number'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Total amount excluding tax' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Transaction', @level2type=N'COLUMN',@level2name=N'Total Excluding Tax'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Total amount of tax' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Transaction', @level2type=N'COLUMN',@level2name=N'Tax Amount'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Total amount including tax' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Transaction', @level2type=N'COLUMN',@level2name=N'Total Including Tax'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Amount still outstanding for this transaction' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Transaction', @level2type=N'COLUMN',@level2name=N'Outstanding Balance'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Has this transaction been finalized?' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Transaction', @level2type=N'COLUMN',@level2name=N'Is Finalized'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Lineage Key for the data load for this row' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Transaction', @level2type=N'COLUMN',@level2name=N'Lineage Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Transaction fact table (financial transactions involving customers and supppliers)' , @level0type=N'SCHEMA',@level0name=N'Fact', @level1type=N'TABLE',@level1name=N'Transaction'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Row ID within the staging table' , @level0type=N'SCHEMA',@level0name=N'Integration', @level1type=N'TABLE',@level1name=N'City_Staging', @level2type=N'COLUMN',@level2name=N'City Staging Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Numeric ID used for reference to a city within the WWI database' , @level0type=N'SCHEMA',@level0name=N'Integration', @level1type=N'TABLE',@level1name=N'City_Staging', @level2type=N'COLUMN',@level2name=N'WWI City ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Formal name of the city' , @level0type=N'SCHEMA',@level0name=N'Integration', @level1type=N'TABLE',@level1name=N'City_Staging', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'State or province for this city' , @level0type=N'SCHEMA',@level0name=N'Integration', @level1type=N'TABLE',@level1name=N'City_Staging', @level2type=N'COLUMN',@level2name=N'State Province'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Country name' , @level0type=N'SCHEMA',@level0name=N'Integration', @level1type=N'TABLE',@level1name=N'City_Staging', @level2type=N'COLUMN',@level2name=N'Country'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Continent that this city is on' , @level0type=N'SCHEMA',@level0name=N'Integration', @level1type=N'TABLE',@level1name=N'City_Staging', @level2type=N'COLUMN',@level2name=N'Continent'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Sales territory for this StateProvince' , @level0type=N'SCHEMA',@level0name=N'Integration', @level1type=N'TABLE',@level1name=N'City_Staging', @level2type=N'COLUMN',@level2name=N'Sales Territory'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Name of the region' , @level0type=N'SCHEMA',@level0name=N'Integration', @level1type=N'TABLE',@level1name=N'City_Staging', @level2type=N'COLUMN',@level2name=N'Region'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Name of the subregion' , @level0type=N'SCHEMA',@level0name=N'Integration', @level1type=N'TABLE',@level1name=N'City_Staging', @level2type=N'COLUMN',@level2name=N'Subregion'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Geographic location of the city' , @level0type=N'SCHEMA',@level0name=N'Integration', @level1type=N'TABLE',@level1name=N'City_Staging', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Latest available population for the City' , @level0type=N'SCHEMA',@level0name=N'Integration', @level1type=N'TABLE',@level1name=N'City_Staging', @level2type=N'COLUMN',@level2name=N'Latest Recorded Population'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Valid from this date and time' , @level0type=N'SCHEMA',@level0name=N'Integration', @level1type=N'TABLE',@level1name=N'City_Staging', @level2type=N'COLUMN',@level2name=N'Valid From'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Valid until this date and time' , @level0type=N'SCHEMA',@level0name=N'Integration', @level1type=N'TABLE',@level1name=N'City_Staging', @level2type=N'COLUMN',@level2name=N'Valid To'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Allows quickly locating by WWI City Key' , @level0type=N'SCHEMA',@level0name=N'Integration', @level1type=N'TABLE',@level1name=N'City_Staging', @level2type=N'INDEX',@level2name=N'IX_Integration_City_Staging_WWI_City_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'City staging table' , @level0type=N'SCHEMA',@level0name=N'Integration', @level1type=N'TABLE',@level1name=N'City_Staging'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Table name' , @level0type=N'SCHEMA',@level0name=N'Integration', @level1type=N'TABLE',@level1name=N'ETL Cutoff', @level2type=N'COLUMN',@level2name=N'Table Name'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Time up to which data has been loaded' , @level0type=N'SCHEMA',@level0name=N'Integration', @level1type=N'TABLE',@level1name=N'ETL Cutoff', @level2type=N'COLUMN',@level2name=N'Cutoff Time'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'ETL Cutoff Times' , @level0type=N'SCHEMA',@level0name=N'Integration', @level1type=N'TABLE',@level1name=N'ETL Cutoff'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'DW key for lineage data' , @level0type=N'SCHEMA',@level0name=N'Integration', @level1type=N'TABLE',@level1name=N'Lineage', @level2type=N'COLUMN',@level2name=N'Lineage Key'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Time when the data load attempt began' , @level0type=N'SCHEMA',@level0name=N'Integration', @level1type=N'TABLE',@level1name=N'Lineage', @level2type=N'COLUMN',@level2name=N'Data Load Started'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Name of the table for this data load event' , @level0type=N'SCHEMA',@level0name=N'Integration', @level1type=N'TABLE',@level1name=N'Lineage', @level2type=N'COLUMN',@level2name=N'Table Name'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Time when the data load attempt completed (successfully or not)' , @level0type=N'SCHEMA',@level0name=N'Integration', @level1type=N'TABLE',@level1name=N'Lineage', @level2type=N'COLUMN',@level2name=N'Data Load Completed'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Was the attempt successful?' , @level0type=N'SCHEMA',@level0name=N'Integration', @level1type=N'TABLE',@level1name=N'Lineage', @level2type=N'COLUMN',@level2name=N'Was Successful'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Time that rows from the source system were loaded up until' , @level0type=N'SCHEMA',@level0name=N'Integration', @level1type=N'TABLE',@level1name=N'Lineage', @level2type=N'COLUMN',@level2name=N'Source System Cutoff Time'
GO
EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Details of data load attempts' , @level0type=N'SCHEMA',@level0name=N'Integration', @level1type=N'TABLE',@level1name=N'Lineage'
GO
USE [master]
GO
ALTER DATABASE [WideWorldImportersDW] SET  READ_WRITE 
GO
