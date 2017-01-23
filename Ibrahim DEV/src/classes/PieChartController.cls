public class PieChartController {
    public List<PieWedgeData> getPieData() {
        List<PieWedgeData> data = new List<PieWedgeData>();
        data.add(new PieWedgeData('Jan', 30));
        data.add(new PieWedgeData('Feb', 15));
        data.add(new PieWedgeData('Mar', 10));
        data.add(new PieWedgeData('Apr', 20));
        data.add(new PieWedgeData('May', 20));
        data.add(new PieWedgeData('Jun', 5));
        return data;
    }
    public class PieWedgeData {
        public String name { get; set; }
        public Integer data { get; set; }
        public String other1 { get; set; }
        public String other2 { get; set; }
        public PieWedgeData(String name, Integer data) {
            this.name = name;
            this.data = data;
            this.other1 = String.valueOf(Math.random());
            this.other2 = String.valueOf(Math.random() * 1000);
        }
    }
}