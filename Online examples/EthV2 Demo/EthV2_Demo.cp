#line 1 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for dspic/include/built_in.h"
#line 1 "c:/users/salvatore/documents/gitkraken repositories/personali/can_debugger/online examples/ethv2 demo/timelib.h"
#line 27 "c:/users/salvatore/documents/gitkraken repositories/personali/can_debugger/online examples/ethv2 demo/timelib.h"
typedef struct
 {
 unsigned char ss;
 unsigned char mn;
 unsigned char hh;
 unsigned char md;
 unsigned char wd;
 unsigned char mo;
 unsigned int yy;
 } TimeStruct;
#line 41 "c:/users/salvatore/documents/gitkraken repositories/personali/can_debugger/online examples/ethv2 demo/timelib.h"
extern long Time_jd1970;
#line 46 "c:/users/salvatore/documents/gitkraken repositories/personali/can_debugger/online examples/ethv2 demo/timelib.h"
long Time_dateToEpoch(TimeStruct *ts);
void Time_epochToDate(long e, TimeStruct *ts);
#line 1 "c:/users/salvatore/documents/gitkraken repositories/personali/can_debugger/online examples/ethv2 demo/__ethenc28j60.h"
#line 120 "c:/users/salvatore/documents/gitkraken repositories/personali/can_debugger/online examples/ethv2 demo/__ethenc28j60.h"
typedef struct
 {
 unsigned char valid;
 unsigned long tmr;
 unsigned char ip[4];
 unsigned char mac[6];
 } SPI_Ethernet_arpCacheStruct;

extern SPI_Ethernet_arpCacheStruct SPI_Ethernet_arpCache[];

extern unsigned char SPI_Ethernet_macAddr[6];
extern unsigned char SPI_Ethernet_ipAddr[4];
extern unsigned char SPI_Ethernet_gwIpAddr[4];
extern unsigned char SPI_Ethernet_ipMask[4];
extern unsigned char SPI_Ethernet_dnsIpAddr[4];
extern unsigned char SPI_Ethernet_rmtIpAddr[4];

extern unsigned long SPI_Ethernet_userTimerSec;

typedef struct {
 unsigned canCloseTCP: 1;
 unsigned isBroadcast: 1;
} TEthPktFlags;
#line 147 "c:/users/salvatore/documents/gitkraken repositories/personali/can_debugger/online examples/ethv2 demo/__ethenc28j60.h"
extern void SPI_Ethernet_Init(unsigned char *resetPort, unsigned char resetBit, unsigned char *CSport, unsigned char CSbit, unsigned char *mac, unsigned char *ip, unsigned char fullDuplex);
extern unsigned char SPI_Ethernet_doPacket();
extern void SPI_Ethernet_putByte(unsigned char b);
extern void SPI_Ethernet_putBytes(unsigned char *ptr, unsigned int n);
extern void SPI_Ethernet_putConstBytes(const unsigned char *ptr, unsigned int n);
extern unsigned char SPI_Ethernet_getByte();
extern void SPI_Ethernet_getBytes(unsigned char *ptr, unsigned int addr, unsigned int n);
extern unsigned int SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength);
extern unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, char * canClose);
extern void SPI_Ethernet_confNetwork(char *ipMask, char *gwIpAddr, char *dnsIpAddr);
#line 1 "c:/users/salvatore/documents/gitkraken repositories/personali/can_debugger/online examples/ethv2 demo/httputils.h"
#line 31 "c:/users/salvatore/documents/gitkraken repositories/personali/can_debugger/online examples/ethv2 demo/httputils.h"
unsigned char HTTP_basicRealm(unsigned int l, unsigned char *passwd);
unsigned char HTTP_getRequest(unsigned char *ptr, unsigned int *len, unsigned int max);
unsigned int HTTP_accessDenied(const unsigned char *zn, const unsigned char *m);
unsigned int http_putString(char *s);
unsigned int http_putConstString(const char *s);
unsigned int http_putConstData(const char *s, unsigned int l);
unsigned int HTTP_redirect(unsigned char *url);
unsigned int HTTP_html(const unsigned char *html);
unsigned int HTTP_imageGIF(const unsigned char *img, unsigned int l);
unsigned int HTTP_error();
#line 55 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
sfr sbit SPI_Ethernet_Rst at LATE8_bit;
sfr sbit SPI_Ethernet_CS at LATD3_bit;
sfr sbit SPI_Ethernet_Rst_Direction at TRISE8_bit;
sfr sbit SPI_Ethernet_CS_Direction at TRISD3_bit;
#line 96 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
unsigned char macAddr[6] = {0x00, 0x14, 0xA5, 0x76, 0x19, 0x3f};
#line 113 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
unsigned char ipAddr[4] = {10, 101, 14, 52};
unsigned char gwIpAddr[4] = {10, 101, 14, 1};
unsigned char ipMask[4] = {255, 255, 255, 0};
unsigned char dnsIpAddr[4] = {10, 101, 14, 99};



TimeStruct ts, ls;
long epoch = 0;
long lastSync = 0;
unsigned long sntpTimer = 0;
unsigned int presTmr = 0;

unsigned char bufInfo[200];
unsigned char *marquee = 0;
unsigned char lcdEvent = 0;
unsigned int lcdTmr = 0;

unsigned char sntpSync = 0;
unsigned char reloadDNS = 1;
unsigned char serverStratum = 0;
unsigned char serverFlags = 0;
char serverPrecision = 0;
#line 140 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
unsigned char *wday[] =
 {
 "Mon",
 "Tue",
 "Wed",
 "Thu",
 "Fri",
 "Sat",
 "Sun"
 };
#line 154 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
unsigned char *mon[] =
 {
 "",
 "Jan",
 "Feb",
 "Mar",
 "Apr",
 "May",
 "Jun",
 "Jul",
 "Aug",
 "Sep",
 "Oct",
 "Nov",
 "Dec"
 };

unsigned int httpCounter = 0;
unsigned char path_private[] = "/admin";

const unsigned char httpHeader[] = "HTTP/1.1 200 OK\nContent-type: ";
const unsigned char httpMimeTypeHTML[] = "text/html\n\n";
const unsigned char httpMimeTypeScript[] = "text/plain\n\n";
#line 181 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
struct
 {
 unsigned char lcdL1;
 unsigned char lcdL2;
 short tz;
 unsigned char sntpIP[4];
 unsigned char sntpServer[128];
 } conf =
 {
 0,
 2,
 0,
 {0, 0, 0, 0},
 "swisstime.ethz.ch"


 };
#line 202 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
const unsigned char *LCDoption[] =
 {
 "Marquee",
 "Date",
 "Time",
 "Off"
 };
#line 217 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
const char *CSSred = "HTTP/1.1 200 OK\nContent-type: text/css\n\nbody {background-color: #ffccdd;}";
#line 223 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
const char *CSSgreen = "HTTP/1.1 200 OK\nContent-type: text/css\n\nbody {background-color: #ddffcc;}";
#line 236 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
const char *HTMLheader = "HTTP/1.1 200 OK\nContent-type: text/html\n\n<HTML><HEAD><TITLE>MikroElektronika Ethernal Clock</TITLE></HEAD><BODY><link rel=\"stylesheet\" type=\"text/css\" href=\"/s.css\"><center><h2>Ethernal Clock</h2>";
#line 248 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
const char *HTMLtime = "<h3>Time | <a href=/2>SNTP</a> | <a href=/3>Network</a> | <a href=/4>System</a> | <a href=/admin>ADMIN</a></h3><script src=/a></script><table border=1 style=\"font-size:20px ;font-family: terminal ;\" width=500><tr><td>Date and Time</td><td align=right><script>document.write(NOW)</script></td></tr><tr><td>Unix Epoch</td><td align=right><script>document.write(EPOCH)</script></td></tr><tr><td>Julian Day</td><td align=right><script>document.write(EPOCH / 24 / 3600 + 2440587.5)</script></td></tr><tr><td>Last sync</td><td align=right><script>document.write(LAST)</script></td></tr>";
#line 263 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
const char *HTMLsntp = "<h3><a href=/>Time</a> | SNTP | <a href=/3>Network</a> | <a href=/4>System</a> | <a href=/admin>ADMIN</a></h3><script src=/b></script><table border=1 style=\"font-size:20px ;font-family: terminal ;\" width=500><tr><td>Server</td><td align=right><script>document.write(SNTP)</script></td></tr><tr><td>Leap</td><td align=right><script>document.write(LEAP)</script></td></tr><tr><td>Version</td><td align=right><script>document.write(VN)</script></td></tr><tr><td>Mode</td><td align=right><script>document.write(MODE)</script></td></tr><tr><td>Stratum</td><td align=right><script>document.write(STRATUM)</script></td></tr><tr><td>Precision</td><td align=right><script>document.write(Math.pow(2, PRECISION - 256))</script></td></tr>";
#line 277 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
const char *HTMLnetwork = "<h3><a href=/>Time</a> | <a href=/2>SNTP</a> | Network | <a href=/4>System</a> | <a href=/admin>ADMIN</a></h3><script src=/c></script><table border=1 style=\"font-size:20px ;font-family: terminal ;\" width=500><tr><td>Clock IP</td><td align=right><script>document.write(IP)</script></td></tr><tr><td>Clock MAC</td><td align=right><script>document.write(MAC)</script></td></tr><tr><td>Network Mask</td><td align=right><script>document.write(MASK)</script></td></tr><tr><td>Gateway</td><td align=right><script>document.write(GW)</script></td></tr><tr><td>DNS</td><td align=right><script>document.write(DNS)</script></td></tr><tr><td>Your IP</td><td align=right><script>document.write(CLIENT)</script></td></tr>";
#line 289 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
const char *HTMLsystem = "<h3><a href=/>Time</a> | <a href=/2>SNTP</a> | <a href=/3>Network</a> | System | <a href=/admin>ADMIN</a></h3><script src=/d></script><table border=1 style=\"font-size:20px ;font-family: terminal ;\" width=500><tr><td>Ethernet device</td><td align=right><script>document.write(SYSTEM)</script></td></tr><tr><td>Fosc</td><td align=right><script>document.write(CLK/1000)</script> Mhz</td></tr><tr><td>Up Since</td><td align=right><script>document.write(UP)</script></td></tr><tr><td>HTTP Request #</td><td align=right><script>document.write(REQ)</script></td></tr>";
#line 303 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
const char *HTMLadmin = "<h3><a href=/>Time</a> | <a href=/2>SNTP</a> | <a href=/3>Network</a> | <a href=/4>System</a> | ADMIN</h3><script src=/admin/s></script><table border=1 style=\"font-size:20px ;font-family: terminal ;\" width=500><tr><td>SNTP Server</td><td align=right><script>document.write(SERVER)</script></td></tr><tr><td>Update clock from SNTP</td><td align=right><a href=/admin/r>now</a></td></tr><tr><td>Time Zone</td><td align=right>GMT <script>document.write(TZ)</script></td></tr><tr><td>LCD Line 1</td><td align=right><script>document.write(LCD1)</script></td></tr><tr><td>LCD Line 2</td><td align=right><script>document.write(LCD2)</script></td></tr>";
#line 315 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
const char *HTMLfooter = "<HTML><HEAD></table><br>See more details on <a href=http://www.micro-examples.com target=_blank>www.micro-examples.com</a><br><a href=http://www.mikroe.com target=_blank>www.mikroe.com</a></center></BODY></HTML>";
#line 325 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
void mkMarquee(unsigned char l)
 {
 unsigned char len;
 char marqeeBuff[17];

 if((*marquee == 0) || (marquee == 0))
 {
 marquee = bufInfo;
 }
 if((len=strlen(marquee)) < 16) {
 memcpy(marqeeBuff, marquee, len);
 memcpy(marqeeBuff+len, bufInfo, 16-len);
 }
 else
 memcpy(marqeeBuff, marquee, 16);
 marqeeBuff[16] = 0;


 SPI_Lcd_Out(l, 1, marqeeBuff);
 }
#line 398 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
void int2str(long l, unsigned char *s)
 {
 unsigned char i, j, n;

 if(l == 0)
 {
 s[0] = '0';
 s[1] = 0;
 }
 else
 {
 if(l < 0)
 {
 l *= -1;
 n = 1;
 }
 else
 {
 n = 0;
 }
 s[0] = 0;
 i = 0;
 while(l > 0)
 {
 for(j = i + 1; j > 0; j--)
 {
 s[j] = s[j - 1];
 }
 s[0] = l % 10;
 s[0] += '0';
 i++;
 l /= 10;
 }
 if(n)
 {
 for(j = i + 1; j > 0; j--)
 {
 s[j] = s[j - 1];
 }
 s[0] = '-';
 }
 }
 }
#line 445 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
void ip2str(unsigned char *s, unsigned char *ip)
 {
 unsigned char i;
 unsigned char buf[4];

 *s = 0;
 for(i = 0; i < 4; i++)
 {
 int2str(ip[i], buf);
 strcat(s, buf);
 if(i != 3)
 strcat(s, ".");
 }
 }
#line 464 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
void ts2str(unsigned char *s, TimeStruct *t, unsigned char m)
 {
 unsigned char tmp[6];
#line 471 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
 if(m &  1 )
 {
 strcpy(s, wday[t->wd]);
 strcat(s, " ");
 ByteToStr(t->md, tmp);
 strcat(s, tmp + 1);
 strcat(s, " ");
 strcat(s, mon[t->mo]);
 strcat(s, " ");
 WordToStr(t->yy, tmp);
 strcat(s, tmp + 1);
 strcat(s, " ");
 }
 else
 {
 *s = 0;
 }
#line 492 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
 if(m &  2 )
 {
 ByteToStr(t->hh, tmp);
 strcat(s, tmp + 1);
 strcat(s, ":");
 ByteToStr(t->mn, tmp);
 if(*(tmp + 1) == ' ')
 {
 *(tmp + 1) = '0';
 }
 strcat(s, tmp + 1);
 strcat(s, ":");
 ByteToStr(t->ss, tmp);
 if(*(tmp + 1) == ' ')
 {
 *(tmp + 1) = '0';
 }
 strcat(s, tmp + 1);
 }
#line 515 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
 if(m &  4 )
 {
 strcat(s, " GMT");
 if(conf.tz > 0)
 {
 strcat(s, "+");
 }
 int2str(conf.tz, s + strlen(s));
 }
 }
#line 529 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
unsigned char nibble2hex(unsigned char n)
 {
 n &= 0x0f;
 if(n >= 0x0a)
 {
 return(n + '7');
 }
 return(n + '0');
 }
#line 542 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
void byte2hex(unsigned char *s, unsigned char v)
 {
 *s++ = nibble2hex(v >> 4);
 *s++ = nibble2hex(v);
 *s = '.';
 }
#line 552 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
unsigned int mkLCDselect(unsigned char l, unsigned char m)
 {
 unsigned char i;
 unsigned int len;

 len =  SPI_Ethernet_putConstString ("<select onChange=\\\"document.location.href = '/admin/");
 SPI_Set_Active(SPI1_Read, SPI1_Write);
 SPI_Ethernet_putByte('0' + l); len++;
 len +=  SPI_Ethernet_putConstString ("/' + this.selectedIndex\\\">");
 for(i = 0; i < 4; i++)
 {
 len +=  SPI_Ethernet_putConstString ("<option ");
 if(i == m)
 {
 len +=  SPI_Ethernet_putConstString (" selected");
 }
 len +=  SPI_Ethernet_putConstString (">");
 len +=  SPI_Ethernet_putConstString (LCDoption[i]);
 }
 len +=  SPI_Ethernet_putConstString ("</select>\";");
 return(len);
 }
#line 578 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
void mkLCDLine(unsigned char l, unsigned char m)
 {
 switch(m)
 {
 case 0:

 memset(bufInfo, 0, sizeof(bufInfo));
 if(lastSync)
 {

 strcpy(bufInfo, "Today is ");
 ts2str(bufInfo + strlen(bufInfo), &ts,  1 );
 strcat(bufInfo, ". Please visit www.micro-examples.com for more details about the Ethernal Clock. You can browse ");
 ip2str(bufInfo + strlen(bufInfo), ipAddr);
 strcat(bufInfo, " to set the clock preferences.    ");
 }
 else
 {

 strcpy(bufInfo, "The SNTP server did not respond, please browse ");
 ip2str(bufInfo + strlen(bufInfo), ipAddr);
 strcat(bufInfo, " to check clock settings.    ");
 }
 mkMarquee(l);
 break;
 case 1:

 if(lastSync)
 {
 ts2str(bufInfo, &ts,  1 );
 }
 else
 {
 strcpy(bufInfo, "Date Not Ready !");
 }

 SPI_Lcd_Out(l, 1, bufInfo);
 break;
 case 2:

 if(lastSync)
 {
 ts2str(bufInfo, &ts,  2 );

 SPI_Lcd_Out(l, 4, bufInfo);
 }
 else
 {
 strcpy(bufInfo, "Time Not Ready !");

 SPI_Lcd_Out(l, 1, bufInfo);
 }
 break;
 }
 }
#line 637 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
void mkSNTPrequest()
 {
 unsigned char sntpPkt[50];
 unsigned char * remoteIpAddr;

 SPI_Set_Active(SPI1_Read, SPI1_Write);
 if (sntpSync)
 if (SPI_Ethernet_UserTimerSec >= sntpTimer)
 if (!lastSync) {
 sntpSync = 0;
 if (!memcmp(conf.sntpIP, "\0\0\0\0", 4))
 reloadDNS = 1 ;
 }

 if(reloadDNS)
 {


 SPI_Lcd_Out(2, 1, "Connecting...   ");

 if(isalpha(*conf.sntpServer))
 {

 memset(conf.sntpIP, 0, 4);
 SPI_Set_Active(SPI1_Read, SPI1_Write);
 if(remoteIpAddr = SPI_Ethernet_dnsResolve(conf.sntpServer, 5))
 {

 memcpy(conf.sntpIP, remoteIpAddr, 4);
 }
 }
 else
 {

 unsigned char *ptr = conf.sntpServer;

 conf.sntpIP[0] = atoi(ptr);
 ptr = strchr(ptr, '.') + 1;
 conf.sntpIP[1] = atoi(ptr);
 ptr = strchr(ptr, '.') + 1;
 conf.sntpIP[2] = atoi(ptr);
 ptr = strchr(ptr, '.') + 1;
 conf.sntpIP[3] = atoi(ptr);
 }

 reloadDNS = 0;

 sntpSync = 0;
 }

 if(sntpSync)
 {
 return;
 }
#line 695 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
 memset(sntpPkt, 0, 48);


 sntpPkt[0] = 0b00011001;




 sntpPkt[2] = 0x0a;


 sntpPkt[3] = 0xfa;


 sntpPkt[6] = 0x44;


 sntpPkt[9] = 0x10;
#line 724 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
 SPI_Set_Active(SPI1_Read, SPI1_Write);
 SPI_Ethernet_sendUDP(conf.sntpIP, 123, 123, sntpPkt, 48);

 sntpSync = 1;
 lastSync = 0;
 SPI_Set_Active(SPI1_Read, SPI1_Write);
 sntpTimer = SPI_Ethernet_UserTimerSec + 5;
 }
#line 736 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags)
 {
 unsigned char dyna[64];
 unsigned char getRequest[ 128  + 1];

 unsigned int len = 0;
 int i;
 unsigned char admin;






 if(localPort != 80)
 {
 return(0);
 }
#line 758 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
 SPI_Set_Active(SPI1_Read, SPI1_Write);
 if(HTTP_getRequest(getRequest, &reqLength,  128 ) == 0)
 {
 return(0);
 }
#line 767 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
 SPI_Set_Active(SPI1_Read, SPI1_Write);
 admin = HTTP_basicRealm(reqLength,  "admin:clock" );

 if(memcmp(getRequest, path_private, sizeof(path_private) - 1) == 0)
 {
 unsigned char *ptr;


 ptr = getRequest + sizeof(path_private) - 1;


 if(admin == 0)
 {
 SPI_Set_Active(SPI1_Read, SPI1_Write);

 len = HTTP_accessDenied( "Ethernal Clock administration" ,  "Authorization Required" );
 }
 else
 {

 if(getRequest[sizeof(path_private)] == 's')
 {

 len =  SPI_Ethernet_putConstString (httpHeader);
 len +=  SPI_Ethernet_putConstString (httpMimeTypeScript);


 len +=  SPI_Ethernet_putConstString ("var LCD1=\"");
 len += mkLCDselect(1, conf.lcdL1);


 len +=  SPI_Ethernet_putConstString ("var LCD2=\"");
 len += mkLCDselect(2, conf.lcdL2);


 len +=  SPI_Ethernet_putConstString ("var SERVER=\"");
 len +=  SPI_Ethernet_putConstString ("<input onChange=\\\"document.location.href = '/admin/n/' + this.value\\\" value=\\\"");
 len +=  SPI_Ethernet_putString (conf.sntpServer);
 len +=  SPI_Ethernet_putConstString ("\\\">\";");


 len +=  SPI_Ethernet_putConstString ("var TZ=\"");
 len +=  SPI_Ethernet_putConstString ("<select onChange=\\\"document.location.href = '/admin/t/' + this.selectedIndex\\\">");
 for(i = -11; i < 12; i++)
 {
 len +=  SPI_Ethernet_putConstString ("<option ");
 if(i == conf.tz)
 {
 len +=  SPI_Ethernet_putConstString (" selected");
 }
 len +=  SPI_Ethernet_putConstString (">");
 int2str(i, dyna);
 len +=  SPI_Ethernet_putString (dyna);
 }
 len +=  SPI_Ethernet_putConstString ("</select>\";");
 }
 else
 {

 switch(getRequest[sizeof(path_private)])
 {
 case '1' :


 SPI_Lcd_Cmd(_LCD_CLEAR);
 conf.lcdL1 = getRequest[sizeof(path_private) + 2] - '0';
 break;
 case '2':


 SPI_Lcd_Cmd(_LCD_CLEAR);
 conf.lcdL2 = getRequest[sizeof(path_private) + 2] - '0';
 break;
 case 'r':

 sntpSync = 0;
 if (!memcmp(conf.sntpIP, "\0\0\0\0", 4))
 reloadDNS = 1 ;
 break;
 case 'n':
 {

 unsigned char *src, *dst, i;

 src = &getRequest[sizeof(path_private) + 2];
 dst = conf.sntpServer;
 for(i = 0; i < 128; i++)
 {
 *dst = *src++;
 if(*dst == ' ')
 {
 *dst = 0;
 break;
 }
 dst++;
 }
 reloadDNS = 1;
 }
 break;
 case 't':

 conf.tz = atoi(&getRequest[sizeof(path_private) + 2]);
 conf.tz -= 11;
 break;
 }


 len +=  SPI_Ethernet_putConstString (HTMLheader);
 len +=  SPI_Ethernet_putConstString (HTMLadmin);
 len +=  SPI_Ethernet_putConstString (HTMLfooter);
 }
 }
 }
 else switch(getRequest[1])
 {

 case 's':

 if(lastSync == 0)
 {
 len =  SPI_Ethernet_putConstString (CSSred);
 }
 else
 {
 len =  SPI_Ethernet_putConstString (CSSgreen);
 }
 break;
 case 'a':

 len =  SPI_Ethernet_putConstString (httpHeader);
 len +=  SPI_Ethernet_putConstString (httpMimeTypeScript);


 ts2str(dyna, &ts,  ( 1  | 2 )  |  4 );
 len +=  SPI_Ethernet_putConstString ("var NOW=\"");
 len +=  SPI_Ethernet_putString (dyna);
 len +=  SPI_Ethernet_putConstString ("\";");


 int2str(epoch, dyna);
 len +=  SPI_Ethernet_putConstString ("var EPOCH=");
 len +=  SPI_Ethernet_putString (dyna);
 len +=  SPI_Ethernet_putConstString (";");


 if(lastSync == 0)
 {
 strcpy(dyna, "???");
 }
 else
 {
 Time_epochToDate(lastSync + conf.tz * 3600, &ls);
 ts2str(dyna, &ls,  ( 1  | 2 )  |  4 );
 }
 len +=  SPI_Ethernet_putConstString ("var LAST=\"");
 len +=  SPI_Ethernet_putString (dyna);
 len +=  SPI_Ethernet_putConstString ("\";");

 break;

 case 'b':

 len =  SPI_Ethernet_putConstString (httpHeader);
 len +=  SPI_Ethernet_putConstString (httpMimeTypeScript);


 ip2str(dyna, conf.sntpIP);
 len +=  SPI_Ethernet_putConstString ("var SNTP=\"");
 len +=  SPI_Ethernet_putString (conf.sntpServer);
 len +=  SPI_Ethernet_putConstString (" (");
 len +=  SPI_Ethernet_putString (dyna);
 len +=  SPI_Ethernet_putConstString (")");
 len +=  SPI_Ethernet_putConstString ("\";");


 if(serverStratum == 0)
 {
 strcpy(dyna, "Unspecified");
 }
 else if(serverStratum == 1)
 {
 strcpy(dyna, "1 (primary)");
 }
 else if(serverStratum < 16)
 {
 int2str(serverStratum, dyna);
 strcat(dyna, "(secondary)");
 }
 else
 {
 int2str(serverStratum, dyna);
 strcat(dyna, " (reserved)");
 }
 len +=  SPI_Ethernet_putConstString ("var STRATUM=\"");
 len +=  SPI_Ethernet_putString (dyna);
 len +=  SPI_Ethernet_putConstString ("\";");


 switch(serverFlags & 0b11000000)
 {
 case 0b00000000: strcpy(dyna, "No warning"); break;
 case 0b01000000: strcpy(dyna, "Last minute has 61 seconds"); break;
 case 0b10000000: strcpy(dyna, "Last minute has 59 seconds"); break;
 case 0b11000000: strcpy(dyna, "SNTP server not synchronized"); break;
 }
 len +=  SPI_Ethernet_putConstString ("var LEAP=\"");
 len +=  SPI_Ethernet_putString (dyna);
 len +=  SPI_Ethernet_putConstString ("\";");

 int2str(serverPrecision, dyna);
 len +=  SPI_Ethernet_putConstString ("var PRECISION=\"");
 len +=  SPI_Ethernet_putString (dyna);
 len +=  SPI_Ethernet_putConstString ("\";");

 switch(serverFlags & 0b00111000)
 {
 case 0b00011000: strcpy(dyna, "IPv4 only"); break;
 case 0b00110000: strcpy(dyna, "IPv4, IPv6 and OSI"); break;
 default: strcpy(dyna, "Undefined"); break;
 }
 len +=  SPI_Ethernet_putConstString ("var VN=\"");
 len +=  SPI_Ethernet_putString (dyna);
 len +=  SPI_Ethernet_putConstString ("\";");

 switch(serverFlags & 0b00000111)
 {
 case 0b00000000: strcpy(dyna, "Reserved"); break;
 case 0b00000001: strcpy(dyna, "Symmetric active"); break;
 case 0b00000010: strcpy(dyna, "Symmetric passive"); break;
 case 0b00000011: strcpy(dyna, "Client"); break;
 case 0b00000100: strcpy(dyna, "Server"); break;
 case 0b00000101: strcpy(dyna, "Broadcast"); break;
 case 0b00000110: strcpy(dyna, "Reserved for NTP control message"); break;
 case 0b00000111: strcpy(dyna, "Reserved for private use"); break;
 }
 len +=  SPI_Ethernet_putConstString ("var MODE=\"");
 len +=  SPI_Ethernet_putString (dyna);
 len +=  SPI_Ethernet_putConstString ("\";");

 break;

 case 'c':

 len =  SPI_Ethernet_putConstString (httpHeader);
 len +=  SPI_Ethernet_putConstString (httpMimeTypeScript);


 ip2str(dyna, ipAddr);
 len +=  SPI_Ethernet_putConstString ("var IP=\"");
 len +=  SPI_Ethernet_putString (dyna);
 len +=  SPI_Ethernet_putConstString ("\";");

 byte2hex(dyna, macAddr[0]);
 byte2hex(dyna + 3, macAddr[1]);
 byte2hex(dyna + 6, macAddr[2]);
 byte2hex(dyna + 9, macAddr[3]);
 byte2hex(dyna + 12, macAddr[4]);
 byte2hex(dyna + 15, macAddr[5]);
 *(dyna + 17) = 0;
 len +=  SPI_Ethernet_putConstString ("var MAC=\"");
 len +=  SPI_Ethernet_putString (dyna);
 len +=  SPI_Ethernet_putConstString ("\";");


 ip2str(dyna, remoteHost);
 len +=  SPI_Ethernet_putConstString ("var CLIENT=\"");
 len +=  SPI_Ethernet_putString (dyna);
 len +=  SPI_Ethernet_putConstString ("\";");


 ip2str(dyna, gwIpAddr);
 len +=  SPI_Ethernet_putConstString ("var GW=\"");
 len +=  SPI_Ethernet_putString (dyna);
 len +=  SPI_Ethernet_putConstString ("\";");


 ip2str(dyna, ipMask);
 len +=  SPI_Ethernet_putConstString ("var MASK=\"");
 len +=  SPI_Ethernet_putString (dyna);
 len +=  SPI_Ethernet_putConstString ("\";");


 ip2str(dyna, dnsIpAddr);
 len +=  SPI_Ethernet_putConstString ("var DNS=\"");
 len +=  SPI_Ethernet_putString (dyna);
 len +=  SPI_Ethernet_putConstString ("\";");

 break;

 case 'd':
 {

 TimeStruct t;

 len =  SPI_Ethernet_putConstString (httpHeader);
 len +=  SPI_Ethernet_putConstString (httpMimeTypeScript);

 len +=  SPI_Ethernet_putConstString ("var SYSTEM=\"ENC28J60\";");

 int2str(Clock_kHz(), dyna);
 len +=  SPI_Ethernet_putConstString ("var CLK=\"");
 len +=  SPI_Ethernet_putString (dyna);
 len +=  SPI_Ethernet_putConstString ("\";");


 int2str(httpCounter, dyna);
 len +=  SPI_Ethernet_putConstString ("var REQ=");
 len +=  SPI_Ethernet_putString (dyna);
 len +=  SPI_Ethernet_putConstString (";");

 SPI_Set_Active(SPI1_Read, SPI1_Write);
 Time_epochToDate(epoch - SPI_Ethernet_UserTimerSec + conf.tz * 3600, &t);
 ts2str(dyna, &t,  ( 1  | 2 )  |  4 );
 len +=  SPI_Ethernet_putConstString ("var UP=\"");
 len +=  SPI_Ethernet_putString (dyna);
 len +=  SPI_Ethernet_putConstString ("\";");


 break;
 }

 case '4':

 len +=  SPI_Ethernet_putConstString (HTMLheader);
 len +=  SPI_Ethernet_putConstString (HTMLsystem);
 len +=  SPI_Ethernet_putConstString (HTMLfooter);
 break;

 case '3':

 len +=  SPI_Ethernet_putConstString (HTMLheader);
 len +=  SPI_Ethernet_putConstString (HTMLnetwork);
 len +=  SPI_Ethernet_putConstString (HTMLfooter);
 break;

 case '2':

 len +=  SPI_Ethernet_putConstString (HTMLheader);
 len +=  SPI_Ethernet_putConstString (HTMLsntp);
 len +=  SPI_Ethernet_putConstString (HTMLfooter);
 break;

 case '1':
 default:

 len +=  SPI_Ethernet_putConstString (HTMLheader);
 len +=  SPI_Ethernet_putConstString (HTMLtime);
 len +=  SPI_Ethernet_putConstString (HTMLfooter);
 }

 httpCounter++;

 return(len);
 }
#line 1125 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
unsigned int SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int destPort, unsigned int reqLength, TEthPktFlags *flags)
 {
 unsigned char i;

 if(destPort == 123)
 {
 unsigned long tts;

 serverFlags = SPI_Ethernet_getByte();
 serverStratum = SPI_Ethernet_getByte();
 SPI_Set_Active(SPI1_Read, SPI1_Write);
 SPI_Ethernet_getByte();
 serverPrecision = SPI_Ethernet_getByte();

 for(i = 0; i < 36; i++)
 {
 SPI_Set_Active(SPI1_Read, SPI1_Write);
 SPI_Ethernet_getByte();
 }


 SPI_Set_Active(SPI1_Read, SPI1_Write);
  ((char *)&tts)[3]  = SPI_Ethernet_getByte();
 SPI_Set_Active(SPI1_Read, SPI1_Write);
  ((char *)&tts)[2]  = SPI_Ethernet_getByte();
 SPI_Set_Active(SPI1_Read, SPI1_Write);
  ((char *)&tts)[1]  = SPI_Ethernet_getByte();
 SPI_Set_Active(SPI1_Read, SPI1_Write);
  ((char *)&tts)[0]  = SPI_Ethernet_getByte();


 epoch = tts - 2208988800;


 lastSync = epoch;


 marquee = bufInfo;

 SPI_Lcd_Cmd(_LCD_CLEAR);
 }
 return(0);
 }
#line 1172 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
void Timer1Int() iv IVT_ADDR_T1INTERRUPT
 {
 presTmr++ ;
 if(presTmr == 5)
 {
 SPI_Set_Active(SPI1_Read, SPI1_Write);
 SPI_Ethernet_UserTimerSec++ ;
 epoch++ ;
 presTmr = 0 ;
 }
 lcdEvent = 1;
 T1IF_bit = 0 ;
 }
#line 1189 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
void main()
 {
 PLLPRE_0_bit = 0;
 PLLPRE_1_bit = 0;
 PLLPRE_2_bit = 0;
 PLLPRE_3_bit = 0;
 PLLPRE_4_bit = 0;

 PLLFBD = 38;

 PLLPOST_0_bit = 0;
 PLLPOST_1_bit = 0;

 ANSELA = 0x00;
 ANSELB = 0x00;
 ANSELC = 0x00;
 ANSELD = 0x00;
 ANSELE = 0x00;
 ANSELG = 0x00;

 PPS_Mapping(65, _INPUT, _SDI1);
 PPS_Mapping(66, _OUTPUT, _SDO1);
 PPS_Mapping(67, _OUTPUT, _SCK1OUT);


 PPS_Mapping(71, _INPUT, _SDI3);
 PPS_Mapping(69, _OUTPUT, _SDO3);
 PPS_Mapping(70, _OUTPUT, _SCK3OUT);
#line 1220 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
 TMR1 = 0;
 PR1 = 31250;
 IPC0 = IPC0 | 0x1000;
 T1CON = 0x8030;
 T1IF_bit = 0 ;
 T1IE_bit = 1 ;
#line 1230 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
 SPI3_Init();

 SPI_Set_Active(SPI3_Read, SPI3_Write);
 SPI_Lcd_Config(0);
 SPI_Lcd_Cmd(_LCD_CLEAR);
 SPI_Lcd_Cmd(_LCD_CURSOR_OFF);

 SPI_Lcd_Out(1, 1, "EthClock Welcome");
 SPI_Lcd_Out(2, 1, "Ethernet init...");
#line 1243 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
 SPI1_Init();



 SPI_Set_Active(SPI1_Read, SPI1_Write);
 SPI_Ethernet_Init(macAddr, ipAddr,  1 );
#line 1253 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
 SPI_Set_Active(SPI3_Read, SPI3_Write);
 SPI_Lcd_Out(2, 1, "Registering...  ");

 SPI_Set_Active(SPI1_Read, SPI1_Write);
 if(SPI_Ethernet_getIpAddress()[0] == 0)
 {
 SPI_Set_Active(SPI1_Read, SPI1_Write);
 while(SPI_Ethernet_initDHCP(5) == 0);
#line 1267 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
 SPI_Set_Active(SPI1_Read, SPI1_Write);
 memcpy(ipAddr, SPI_Ethernet_getIpAddress(), 4);
 SPI_Set_Active(SPI1_Read, SPI1_Write);
 memcpy(ipMask, SPI_Ethernet_getIpMask(), 4);
 SPI_Set_Active(SPI1_Read, SPI1_Write);
 memcpy(gwIpAddr, SPI_Ethernet_getGwIpAddress(), 4);
 SPI_Set_Active(SPI1_Read, SPI1_Write);
 memcpy(dnsIpAddr, SPI_Ethernet_getDnsIpAddress(), 4);
 }
 else
 {
 SPI_Set_Active(SPI1_Read, SPI1_Write);
 SPI_Ethernet_confNetwork(ipMask, gwIpAddr, dnsIpAddr);
 }

 while(1)
 {
#line 1287 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
 SPI_Set_Active(SPI1_Read, SPI1_Write);
 SPI_Ethernet_doPacket();


 mkSNTPrequest();
#line 1314 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/Online examples/EthV2 Demo/EthV2_Demo.c"
 Time_epochToDate(epoch + conf.tz * 3600l, &ts);
 if(lcdEvent)
 {
 mkLCDLine(1, conf.lcdL1);
 mkLCDLine(2, conf.lcdL2);
 lcdEvent = 0;
 marquee++;
 }
 }
 }
