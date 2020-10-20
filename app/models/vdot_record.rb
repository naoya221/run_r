class VdotRecord < ActiveHash::Base
  self.data = [
    { id: 1, five_km_minute: '30', five_km_second: '40', ten_km_minute: '63', ten_km_second: '46', half_hour: '2', half_minute: '21', half_second: '04', full_hour: '4', full_minute: '49', full_second: '17' },
    { id: 2, five_km_minute: '29', five_km_second: '51', ten_km_minute: '62', ten_km_second: '03', half_hour: '2', half_minute: '17', half_second: '21', full_hour: '4', full_minute: '41', full_second: '57' },
    { id: 3, five_km_minute: '29', five_km_second: '05', ten_km_minute: '60', ten_km_second: '26', half_hour: '2', half_minute: '13', half_second: '49', full_hour: '4', full_minute: '34', full_second: '59' },
    { id: 4, five_km_minute: '28', five_km_second: '21', ten_km_minute: '58', ten_km_second: '54', half_hour: '2', half_minute: '10', half_second: '27', full_hour: '4', full_minute: '28', full_second: '22' },
    { id: 5, five_km_minute: '27', five_km_second: '39', ten_km_minute: '57', ten_km_second: '26', half_hour: '2', half_minute: '07', half_second: '16', full_hour: '4', full_minute: '22', full_second: '03' },
    { id: 6, five_km_minute: '27', five_km_second: '00', ten_km_minute: '56', ten_km_second: '03', half_hour: '2', half_minute: '04', half_second: '13', full_hour: '4', full_minute: '16', full_second: '03' },
    { id: 7, five_km_minute: '26', five_km_second: '22', ten_km_minute: '54', ten_km_second: '44', half_hour: '2', half_minute: '01', half_second: '19', full_hour: '4', full_minute: '10', full_second: '19' },
    { id: 8, five_km_minute: '25', five_km_second: '46', ten_km_minute: '53', ten_km_second: '29', half_hour: '1', half_minute: '58', half_second: '34', full_hour: '4', full_minute: '04', full_second: '50' },
    { id: 9, five_km_minute: '25', five_km_second: '12', ten_km_minute: '52', ten_km_second: '17', half_hour: '1', half_minute: '55', half_second: '55', full_hour: '3', full_minute: '59', full_second: '35' },
    { id: 10, five_km_minute: '24', five_km_second: '39', ten_km_minute: '51', ten_km_second: '09', half_hour: '1', half_minute: '53', half_second: '24', full_hour: '3', full_minute: '54', full_second: '34' },

    { id: 11, five_km_minute: '24', five_km_second: '08', ten_km_minute: '50', ten_km_second: '03', half_hour: '1', half_minute: '50', half_second: '59', full_hour: '3', full_minute: '49', full_second: '45' },
    { id: 12, five_km_minute: '24', five_km_second: '38', ten_km_minute: '49', ten_km_second: '01', half_hour: '1', half_minute: '48', half_second: '40', full_hour: '3', full_minute: '45', full_second: '09' },
    { id: 13, five_km_minute: '23', five_km_second: '09', ten_km_minute: '48', ten_km_second: '01', half_hour: '1', half_minute: '46', half_second: '27', full_hour: '3', full_minute: '40', full_second: '43' },
    { id: 14, five_km_minute: '23', five_km_second: '41', ten_km_minute: '47', ten_km_second: '04', half_hour: '1', half_minute: '44', half_second: '20', full_hour: '3', full_minute: '36', full_second: '28' },
    { id: 15, five_km_minute: '22', five_km_second: '15', ten_km_minute: '46', ten_km_second: '09', half_hour: '1', half_minute: '42', half_second: '17', full_hour: '3', full_minute: '32', full_second: '23' },
    { id: 16, five_km_minute: '22', five_km_second: '50', ten_km_minute: '45', ten_km_second: '16', half_hour: '1', half_minute: '40', half_second: '20', full_hour: '3', full_minute: '28', full_second: '26' },
    { id: 17, five_km_minute: '21', five_km_second: '25', ten_km_minute: '44', ten_km_second: '25', half_hour: '1', half_minute: '38', half_second: '27', full_hour: '3', full_minute: '24', full_second: '39' },
    { id: 18, five_km_minute: '21', five_km_second: '02', ten_km_minute: '43', ten_km_second: '36', half_hour: '1', half_minute: '36', half_second: '38', full_hour: '3', full_minute: '21', full_second: '00' },
    { id: 19, five_km_minute: '21', five_km_second: '39', ten_km_minute: '42', ten_km_second: '50', half_hour: '1', half_minute: '34', half_second: '53', full_hour: '3', full_minute: '17', full_second: '29' },
    { id: 20, five_km_minute: '20', five_km_second: '18', ten_km_minute: '42', ten_km_second: '04', half_hour: '1', half_minute: '33', half_second: '12', full_hour: '3', full_minute: '14', full_second: '06' },

    { id: 21, five_km_minute: '19', five_km_second: '57', ten_km_minute: '41', ten_km_second: '21', half_hour: '1', half_minute: '31', half_second: '35', full_hour: '3', full_minute: '10', full_second: '49' },
    { id: 22, five_km_minute: '19', five_km_second: '36', ten_km_minute: '40', ten_km_second: '39', half_hour: '1', half_minute: '30', half_second: '02', full_hour: '3', full_minute: '07', full_second: '39' },
    { id: 23, five_km_minute: '19', five_km_second: '17', ten_km_minute: '39', ten_km_second: '59', half_hour: '1', half_minute: '28', half_second: '31', full_hour: '3', full_minute: '04', full_second: '36' },
    { id: 24, five_km_minute: '18', five_km_second: '58', ten_km_minute: '39', ten_km_second: '20', half_hour: '1', half_minute: '27', half_second: '04', full_hour: '3', full_minute: '01', full_second: '39' },
    { id: 25, five_km_minute: '18', five_km_second: '40', ten_km_minute: '38', ten_km_second: '42', half_hour: '1', half_minute: '25', half_second: '40', full_hour: '2', full_minute: '58', full_second: '47' }
  ]
end
